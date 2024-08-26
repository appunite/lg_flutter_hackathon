import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lg_flutter_hackathon/buttons/button_with_text.dart';
import 'package:lg_flutter_hackathon/constants/design_consts.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lg_flutter_hackathon/audio/audio_controller.dart';
import 'package:lg_flutter_hackathon/dependencies.dart';

class ConfirmationPopUp extends StatelessWidget {
  const ConfirmationPopUp({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final audioController = sl.get<AudioController>();

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            ImageAssets.tutorialContainer,
            width: screenWidth / 2,
          ),
          Positioned(
            top: screenHeight / 6,
            child: Text(
              title,
              style: TextStyle(
                fontFamily: DesignConsts.fontFamily,
                color: Colors.white,
                fontSize: screenWidth / 40,
              ),
            ),
          ),
          Positioned(
            right: screenWidth / 12,
            bottom: screenHeight / 15,
            child: ButtonWithText(
              text: 'Cancel',
              onTap: () {
                audioController.setSong(audioController.themeSong);
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            bottom: screenHeight / 15,
            left: screenWidth / 12,
            child: ButtonWithText(
              text: 'Exit',
              onTap: () {
                audioController.setSong(audioController.themeSong);
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ),
        ],
      ),
    );
  }
}
