import 'package:flutter/material.dart';
import 'package:lg_flutter_hackathon/constants/design_consts.dart';

class StoryTextContainer extends StatelessWidget {
  const StoryTextContainer({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Container(
      width: screenWidth / 1.8,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF402B16).withOpacity(.8),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: DesignConsts.fontFamily,
          color: Colors.white,
          fontSize: screenWidth / DesignConsts.storyFontSizeFactor,
        ),
      ),
    );
  }
}
