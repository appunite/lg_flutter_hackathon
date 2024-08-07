import 'dart:typed_data';
import 'dart:ui';

class DrawingDetails {
  final List<Offset?> points;
  final Uint8List drawnImageBytes;
  final double accuracy;
  final int totalBlackPixels;
  final int correctPixels;
  final int totalDrawnOutside;
  final int totalDrawnPixels;

  DrawingDetails({
    required this.points,
    required this.drawnImageBytes,
    required this.accuracy,
    required this.totalBlackPixels,
    required this.correctPixels,
    required this.totalDrawnOutside,
    required this.totalDrawnPixels,
  });

  @override
  String toString() {
    return 'DrawingDetails(accuracy: $accuracy, totalBlackPixels: $totalBlackPixels, correctPixels: $correctPixels, totalDrawnOutside: $totalDrawnOutside, totalDrawnPixels: $totalDrawnPixels)';
  }
}
