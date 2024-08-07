import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lg_flutter_hackathon/battle/domain/drawing_details_entity.dart';
import 'dart:ui' as ui;
import 'package:lg_flutter_hackathon/battle/domain/glyph_entity.dart';
import 'package:lg_flutter_hackathon/battle/presentation/widgets/drawing_painter.dart';

class DrawingOverlay extends StatefulWidget {
  final ValueChanged<DrawingDetails> onDrawingCompleted;
  final double thresholdPercentage;
  final GlyphEntity glyphAsset;
  final double drawingAreaSize;

  const DrawingOverlay({
    super.key,
    required this.onDrawingCompleted,
    required this.thresholdPercentage,
    required this.glyphAsset,
    required this.drawingAreaSize,
  });

  @override
  State<DrawingOverlay> createState() => _DrawingOverlayState();
}

class _DrawingOverlayState extends State<DrawingOverlay> {
  List<Offset?> points = [];
  Uint8List? drawnImageBytes;
  ui.Image? backgroundImage;
  double strokeWidth = 5.0;

  @override
  void initState() {
    super.initState();
    _loadPresentationImage();
  }

  Future<void> _loadPresentationImage() async {
    final ByteData data = await rootBundle.load(widget.glyphAsset.glyphPresentation);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    setState(() {
      backgroundImage = frame.image;
      _calculateStrokeWidth();
    });
  }

  void _calculateStrokeWidth() {
    const double baseStrokeWidth = 10.0;
    final double scaleFactor = widget.drawingAreaSize / widget.drawingAreaSize;
    strokeWidth = baseStrokeWidth * scaleFactor;
  }

  Future<DrawingDetails> _saveAndCompareDrawing() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, widget.drawingAreaSize, widget.drawingAreaSize));

    canvas.drawRect(
      Rect.fromLTWH(0, 0, widget.drawingAreaSize, widget.drawingAreaSize),
      Paint()..color = Colors.white,
    );

    final painter = DrawPainter(points, null, strokeWidth);
    painter.paint(canvas, Size(widget.drawingAreaSize, widget.drawingAreaSize));
    final picture = recorder.endRecording();
    final imgBytes = await (await picture.toImage(widget.drawingAreaSize.toInt(), widget.drawingAreaSize.toInt()))
        .toByteData(format: ui.ImageByteFormat.png);

    drawnImageBytes = imgBytes!.buffer.asUint8List();

    final resizedDrawnImage =
        await _resizeImageAndConvertToBW(drawnImageBytes!, backgroundImage!.width, backgroundImage!.height);

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
      points: points,
      drawnImageBytes: drawnImage,
      accuracy: accuracy,
      totalBlackPixels: blackPixelNeededFromOriginalImage,
      correctPixels: correctPixels,
      totalDrawnOutside: totalDrawnOutside,
      totalDrawnPixels: totalDrawnPixels,
    );
  }

  @override
  Widget build(BuildContext context) => Center(
        child: GestureDetector(
          onPanUpdate: (details) => setState(() {
            Offset localPosition = details.localPosition;
            points.add(localPosition);
          }),
          onPanEnd: (details) async {
            points.add(null);
            DrawingDetails details = await _saveAndCompareDrawing();
            widget.onDrawingCompleted(details);
            setState(() => points.clear());
          },
          child: SizedBox(
            width: widget.drawingAreaSize,
            height: widget.drawingAreaSize,
            child: CustomPaint(
              painter: DrawPainter(points, backgroundImage, strokeWidth),
              size: Size.infinite,
            ),
          ),
        ),
      );
}
