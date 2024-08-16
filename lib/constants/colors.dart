import 'package:flutter/material.dart';

class AppColors {
  static const LinearGradient healthBarGreen = LinearGradient(
    colors: [Color(0xFF2CB63A), Color(0xFF3DE558)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient healthBarOrange = LinearGradient(
    colors: [Color(0xFFB65E2C), Color(0xFFE57C3D)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient healthBarRed = LinearGradient(
    colors: [Color(0xFFB62C2C), Color(0xFFE53D3D)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  AppColors._();
}
