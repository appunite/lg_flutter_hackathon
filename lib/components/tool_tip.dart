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
    final hasNextItem = currentDisplayIndex < totalLength;
    final hasPreviousItem = currentDisplayIndex != 1;

    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          ImageAssets.tutorialContainer,
          fit: BoxFit.contain,
          width: screenWidth / DesignConsts.containerWidthFactor,
          height: screenHeight / DesignConsts.containerHeightFactor,
        ),
        Container(
          alignment: Alignment.center,
          width: 400,
          height: screenHeight / DesignConsts.containerHeightFactor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: DesignConsts.fontFamily,
                    fontSize: screenWidth / DesignConsts.numberFontSizeFactor,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: screenHeight / DesignConsts.tutorialColumnSpacingFactor),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PushableButton(
                    onPressed: () {
                      controller.dismiss();
                    },
                    child: Opacity(
                      opacity: 1,
                      child: SvgPicture.asset(
                        hasPreviousItem ? ImageAssets.tutorialBackButton : ImageAssets.tutorialSkipButton,
                        fit: BoxFit.contain,
                        width: screenWidth / DesignConsts.buttonWidthFactor,
                        height: screenHeight / DesignConsts.buttonHeightFactor,
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
                        ImageAssets.tutorialNextButton,
                        fit: BoxFit.contain,
                        width: screenWidth / DesignConsts.buttonWidthFactor,
                        height: screenHeight / DesignConsts.buttonHeightFactor,
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
