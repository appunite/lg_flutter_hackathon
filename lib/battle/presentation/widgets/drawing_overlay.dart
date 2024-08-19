import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lg_flutter_hackathon/audio/audio_controller.dart';
import 'package:lg_flutter_hackathon/audio/sounds.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/drawing_details_entity.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/drawing_mode_enum.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/glyph_entity.dart';
import 'package:lg_flutter_hackathon/battle/presentation/widgets/drawing_painter.dart';
import 'package:lg_flutter_hackathon/battle/presentation/widgets/overlay_widget.dart';
import 'package:lg_flutter_hackathon/constants/design_consts.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';
import 'package:provider/provider.dart';

class DrawingOverlay extends StatefulWidget {
  final ValueChanged<DrawingDetails> onDrawingCompleted;
  final double thresholdPercentage;
  final GlyphEntity glyphAsset;
  final double drawingAreaSize;
  final DrawingModeEnum drawingMode;

  const DrawingOverlay({
    super.key,
    required this.onDrawingCompleted,
    required this.thresholdPercentage,
    required this.glyphAsset,
    required this.drawingAreaSize,
    required this.drawingMode,
  });

  @override
  State<DrawingOverlay> createState() => _DrawingOverlayState();
}

class _DrawingOverlayState extends State<DrawingOverlay> {
  final List<Offset?> _points = [];
  Offset? _currentPenPosition;

  Uint8List? _drawnImageBytes;
  ui.Image? _backgroundImage;
  final double _strokeWidth = 16;

  @override
  void initState() {
    super.initState();
    _loadPresentationImage();
  }

  Future<void> _loadPresentationImage() async {
    final ByteData data = await rootBundle.load(widget.glyphAsset.glyphPresentation);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    setState(() => _backgroundImage = frame.image);
  }

  Future<DrawingDetails> _saveAndCompareDrawing() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, widget.drawingAreaSize, widget.drawingAreaSize));

    canvas.drawRect(
      Rect.fromLTWH(0, 0, widget.drawingAreaSize, widget.drawingAreaSize),
      Paint()..color = Colors.white,
    );

    final painter = DrawPainter(_points, null, _strokeWidth);
    painter.paint(canvas, Size(widget.drawingAreaSize, widget.drawingAreaSize));
    final picture = recorder.endRecording();
    final imgBytes = await (await picture.toImage(widget.drawingAreaSize.toInt(), widget.drawingAreaSize.toInt()))
        .toByteData(format: ui.ImageByteFormat.png);

    _drawnImageBytes = imgBytes!.buffer.asUint8List();

    final resizedDrawnImage =
        await _resizeImageAndConvertToBW(_drawnImageBytes!, _backgroundImage!.width, _backgroundImage!.height);

    return await _compareImages(widget.glyphAsset.glyphCompare, resizedDrawnImage);
  }

  Future<Uint8List> _resizeImageAndConvertToBW(Uint8List data, int targetWidth, int targetHeight) async {
    final codec = await ui.instantiateImageCodec(data);
    final frame = await codec.getNextFrame();
    final originalImage = frame.image;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, targetWidth.toDouble(), targetHeight.toDouble()));
    canvas.drawImageRect(
      originalImage,
      Rect.fromLTWH(0, 0, originalImage.width.toDouble(), originalImage.height.toDouble()),
      Rect.fromLTWH(0, 0, targetWidth.toDouble(), targetHeight.toDouble()),
      Paint(),
    );

    final picture = recorder.endRecording();
    final img = await picture.toImage(targetWidth, targetHeight);
    final byteData = await img.toByteData(format: ui.ImageByteFormat.rawRgba);
    final resizedImageBytes = byteData!.buffer.asUint8List();

    final bwImageBytes = Uint8List(resizedImageBytes.length);
    for (int i = 0; i < resizedImageBytes.length; i += 4) {
      final gray =
          (0.299 * resizedImageBytes[i] + 0.587 * resizedImageBytes[i + 1] + 0.114 * resizedImageBytes[i + 2]).round();
      final binary = gray > 128 ? 255 : 0;
      bwImageBytes[i] = bwImageBytes[i + 1] = bwImageBytes[i + 2] = binary;
      bwImageBytes[i + 3] = resizedImageBytes[i + 3];
    }

    final recorderBW = ui.PictureRecorder();
    final canvasBW = Canvas(recorderBW, Rect.fromLTWH(0, 0, targetWidth.toDouble(), targetHeight.toDouble()));
    final paint = Paint();
    final bwImage = await decodeImageFromPixels(bwImageBytes, targetWidth, targetHeight, ui.PixelFormat.rgba8888);
    canvasBW.drawImage(bwImage, Offset.zero, paint);

    final pictureBW = recorderBW.endRecording();
    final imgBW = await pictureBW.toImage(targetWidth, targetHeight);
    final byteDataBW = await imgBW.toByteData(format: ui.ImageByteFormat.png);
    return byteDataBW!.buffer.asUint8List();
  }

  Future<ui.Image> decodeImageFromPixels(Uint8List pixels, int width, int height, ui.PixelFormat format) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromPixels(pixels, width, height, format, (ui.Image img) {
      completer.complete(img);
    });
    return completer.future;
  }

  Future<DrawingDetails> _compareImages(String originalImagePath, Uint8List drawnImage) async {
    final ByteData originalImageData = await rootBundle.load(originalImagePath);
    final codecOriginal = await ui.instantiateImageCodec(originalImageData.buffer.asUint8List());
    final frameOriginal = await codecOriginal.getNextFrame();
    final originalImage = frameOriginal.image;

    final codecDrawn = await ui.instantiateImageCodec(drawnImage);
    final frameDrawn = await codecDrawn.getNextFrame();
    final drawnImageInstance = frameDrawn.image;

    final ByteData? originalImageByteData = await originalImage.toByteData(format: ui.ImageByteFormat.rawRgba);
    final ByteData? drawnImageByteData = await drawnImageInstance.toByteData(format: ui.ImageByteFormat.rawRgba);

    final Uint8List originalPixels = originalImageByteData!.buffer.asUint8List();
    final Uint8List drawnPixels = drawnImageByteData!.buffer.asUint8List();

    int correctPixels = 0;
    int blackPixelNeededFromOriginalImage = 0;
    int totalDrawnOutside = 0;
    int totalDrawnPixels = 0;

    for (int i = 0; i < originalPixels.length; i += 4) {
      int originalGray =
          (0.299 * originalPixels[i] + 0.587 * originalPixels[i + 1] + 0.114 * originalPixels[i + 2]).round();
      int originalBinary = originalGray > 128 ? 255 : 0;

      int drawnGray = (0.299 * drawnPixels[i] + 0.587 * drawnPixels[i + 1] + 0.114 * drawnPixels[i + 2]).round();
      int drawnBinary = drawnGray > 128 ? 255 : 0;

      if (drawnBinary == 0) {
        totalDrawnPixels++;
      }

      if (originalBinary == 0) {
        blackPixelNeededFromOriginalImage++;
        if (drawnBinary == 0) {
          correctPixels++;
        }
      }
    }

    totalDrawnOutside += (totalDrawnPixels - correctPixels);

    double accuracy = 0;

    if (blackPixelNeededFromOriginalImage > 0) {
      double outsidePercentage = (totalDrawnOutside / blackPixelNeededFromOriginalImage);
      if (outsidePercentage <= widget.thresholdPercentage) {
        accuracy = (correctPixels / blackPixelNeededFromOriginalImage) * 100;
      }
    }

    return DrawingDetails(
      points: _points,
      drawnImageBytes: drawnImage,
      accuracy: accuracy,
      totalBlackPixels: blackPixelNeededFromOriginalImage,
      correctPixels: correctPixels,
      totalDrawnOutside: totalDrawnOutside,
      totalDrawnPixels: totalDrawnPixels,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double drawingBoardSize = widget.drawingAreaSize * 2;
    final double glyphSize = widget.drawingAreaSize;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final audioController = context.watch<AudioController>();

    return Stack(
      alignment: Alignment.center,
      children: [
        const OverlayWidget(),
        Positioned(
          top: 64,
          child: Text(
            'Time for ${widget.drawingMode.name}!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: DesignConsts.fontFamily,
              fontSize: screenWidth / 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: drawingBoardSize,
            height: drawingBoardSize,
            child: Stack(
              children: [
                SvgPicture.asset(
                  ImageAssets.drawingBoard,
                  width: drawingBoardSize,
                  height: drawingBoardSize,
                ),
                Center(
                  child: GestureDetector(
                    onPanStart: (details) => setState(() {
                      _currentPenPosition = details.localPosition;
                    }),
                    onPanUpdate: (details) => setState(() {
                      audioController.playSfx(SfxType.drawing);
                      Offset localPosition = details.localPosition;
                      _points.add(localPosition);
                      if (_points.length > 1 && _points[_points.length - 2] != null) {}
                      _currentPenPosition = localPosition;
                    }),
                    onPanEnd: (details) async {
                      _points.add(null);
                      DrawingDetails details = await _saveAndCompareDrawing();
                      widget.onDrawingCompleted(details);
                      setState(() {
                        _points.clear();
                        _currentPenPosition = null;
                      });
                    },
                    child: SizedBox(
                      width: glyphSize,
                      height: glyphSize,
                      child: CustomPaint(
                        painter: DrawPainter(_points, _backgroundImage, _strokeWidth),
                        size: Size.infinite,
                      ),
                    ),
                  ),
                ),
                if (_currentPenPosition != null) _buildMagicPen(glyphSize),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //TODO: As suggestion we can add a fade in and fade out animation for the magic pen
  Widget _buildMagicPen(double glyphSize) {
    double offsetX = glyphSize * -0.8;
    double offsetY = glyphSize * -0.25;

    return Positioned(
      left: _currentPenPosition!.dx - offsetX,
      top: _currentPenPosition!.dy - offsetY,
      child: Transform.rotate(
        angle: -45,
        child: SvgPicture.asset(
          ImageAssets.magicPenSvg,
          width: glyphSize,
          height: glyphSize,
        ),
      ),
    );
  }
}
