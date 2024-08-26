import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lg_flutter_hackathon/components/pushable_button.dart';
import 'package:lg_flutter_hackathon/constants/design_consts.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';

class MTooltip extends StatelessWidget {
  final TooltipController controller;
  final String title;

  const MTooltip({
    super.key,
    required this.controller,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final currentDisplayIndex = controller.nextPlayIndex + 1;
    final totalLength = controller.playWidgetLength;
    final hasPreviousItem = currentDisplayIndex != 1;
    final hasNextItem = currentDisplayIndex < totalLength;

    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    final containerWidth = screenWidth * 0.4;
    final containerHeight = screenHeight * 0.3;
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          ImageAssets.tutorialContainer,
          fit: BoxFit.contain,
          width: containerWidth,
          height: containerHeight,
        ),
        Container(
          alignment: Alignment.center,
          width: containerWidth,
          height: containerHeight,
          padding: EdgeInsets.symmetric(
                horizontal: containerWidth * 0.21,
              ) +
              EdgeInsets.only(top: containerHeight * 0.2, bottom: containerHeight * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: containerHeight * 0.45,
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: DesignConsts.fontFamily,
                    fontSize: screenWidth / DesignConsts.tutorialFontSizeFactor,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PushableButton(
                    onPressed: () {
                      if (hasPreviousItem) {
                        controller.previous();
                      } else {
                        controller.dismiss();
                      }
                    },
                    child: Opacity(
                      opacity: 1,
                      child: SvgPicture.asset(
                        hasPreviousItem ? ImageAssets.tutorialBackButton : ImageAssets.tutorialSkipButton,
                        fit: BoxFit.contain,
                        width: containerWidth * 0.2,
                        height: containerHeight * 0.2,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth / DesignConsts.tutorialButtonSpacingFactor),
                  PushableButton(
                    onPressed: () {
                      controller.next();
                    },
                    child: Opacity(
                      opacity: 1,
                      child: SvgPicture.asset(
                        hasNextItem ? ImageAssets.tutorialNextButton : ImageAssets.tutorialStartButton,
                        fit: BoxFit.contain,
                        width: containerWidth * 0.2,
                        height: containerHeight * 0.2,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
