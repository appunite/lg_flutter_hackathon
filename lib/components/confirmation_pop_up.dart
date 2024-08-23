import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lg_flutter_hackathon/components/pushable_button.dart';
import 'package:lg_flutter_hackathon/constants/design_consts.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';

class ConfirmationPopUp extends StatelessWidget {
  const ConfirmationPopUp({super.key, required this.title, this.alertMessage});

  final String title;
  final String? alertMessage;

  @override
  Widget build(BuildContext context) {
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
                      Navigator.pop(context);
                    },
                    child: Opacity(
                      opacity: 1,
                      child: SvgPicture.asset(
                        ImageAssets.cancelButton,
                        fit: BoxFit.contain,
                        width: containerWidth * 0.2,
                        height: containerHeight * 0.2,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth / DesignConsts.tutorialButtonSpacingFactor),
                  PushableButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/');
                    },
                    child: Opacity(
                      opacity: 1,
                      child: SvgPicture.asset(
                        ImageAssets.yesButton,
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
