import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lg_flutter_hackathon/components/pushable_button.dart';
import 'package:lg_flutter_hackathon/constants/design_consts.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';

class StoryButton extends StatelessWidget {
  const StoryButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return PushableButton(
      onPressed: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            ImageAssets.buttonNext,
            width: screenWidth / 20,
            height: screenWidth / 30,
          ),
          Text(
            text,
            style: TextStyle(
              fontFamily: DesignConsts.fontFamily,
              color: Colors.white,
              fontSize: screenWidth / 60,
            ),
          )
        ],
      ),
    );
  }
}
