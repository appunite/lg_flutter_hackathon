import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class DrawPainter extends CustomPainter {
  final List<Offset?> points;
  final ui.Image? backgroundImage;
  final double strokeWidth;

  DrawPainter(this.points, this.backgroundImage, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    if (backgroundImage != null) {
      paintImage(
        canvas: canvas,
        image: backgroundImage!,
        rect: Rect.fromLTWH(0, 0, size.width, size.height),
        fit: BoxFit.cover,
      );
    }

    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
