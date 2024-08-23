import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lg_flutter_hackathon/constants/design_consts.dart';

class StoryTextContainer extends StatelessWidget {
  const StoryTextContainer({super.key, required this.text, this.leadingAsset});

  final String text;
  final String? leadingAsset;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      width: screenWidth / 1.8,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF402B16).withOpacity(.8),
      ),
      child: Row(
        children: [
          if (leadingAsset != null)
            SvgPicture.asset(
              height: screenHeight / 10,
              leadingAsset!,
              fit: BoxFit.cover,
              placeholderBuilder: (BuildContext context) => const SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: DesignConsts.fontFamily,
                color: Colors.white,
                fontSize: screenWidth / DesignConsts.storyFontSizeFactor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
