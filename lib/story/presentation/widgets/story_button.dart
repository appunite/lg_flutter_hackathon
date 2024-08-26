import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lg_flutter_hackathon/components/pushable_button.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';

class StoryButton extends StatelessWidget {
  const StoryButton({
    super.key,
    required this.onTap,
    this.isSkip = false,
  });

  final VoidCallback onTap;
  final bool isSkip;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return PushableButton(
      onPressed: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            isSkip ? ImageAssets.tutorialSkipButton : ImageAssets.tutorialNextButton,
            width: screenWidth / 20,
            height: screenWidth / 30,
          ),
        ],
      ),
    );
  }
}
