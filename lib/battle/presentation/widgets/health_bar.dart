import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';

class HealthBar extends StatelessWidget {
  const HealthBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final healthBarWidth = screenWidth / 4;
    final containerWidth = screenWidth / 6;

    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          ImageAssets.healthBarBackground,
          width: healthBarWidth,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 64,
            vertical: 16,
          ),
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: containerWidth,
                  color: Colors.red,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  ImageAssets.healthBarForeground,
                  width: healthBarWidth * 0.8,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
