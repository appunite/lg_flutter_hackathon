import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lg_flutter_hackathon/constants/design_consts.dart';
import 'package:lg_flutter_hackathon/main_menu/main_menu_screen.dart';
import 'package:lg_flutter_hackathon/story/domain/opening_story_enum.dart';
import 'package:lg_flutter_hackathon/story/presentation/widgets/story_button.dart';
import 'package:lg_flutter_hackathon/story/presentation/widgets/story_text_container.dart';
import 'package:lg_flutter_hackathon/utils/transitions.dart';

class OpeningStoryScreen extends StatelessWidget {
  const OpeningStoryScreen({
    super.key,
    required this.step,
  });

  final OpeningStoryStep step;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              step.backgroundPath,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: screenHeight / DesignConsts.storyScreenBottomPositionFactor,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                StoryTextContainer(text: step.text),
              ],
            ),
          ),
          Positioned(
            bottom: screenHeight / DesignConsts.storyScreenBottomPositionFactor / 2,
            right: screenWidth / 5,
            child: StoryButton(
              onTap: () => _onNextPressed(context),
            ),
          ),
          Positioned(
            bottom: screenHeight / DesignConsts.storyScreenBottomPositionFactor / 2,
            left: screenWidth / 5,
            child: StoryButton(
              isSkip: true,
              onTap: () => _navigateToMainMenu(context),
            ),
          ),
        ],
      ),
    );
  }

  void _onNextPressed(BuildContext context) {
    final currentIndex = OpeningStoryStep.values.indexOf(step);
    if (currentIndex == OpeningStoryStep.values.length - 1) {
      _navigateToMainMenu(context);
    } else {
      Navigator.pushReplacement(
        context,
        FadeRoute(
          page: OpeningStoryScreen(
            step: OpeningStoryStep.values[currentIndex + 1],
          ),
        ),
      );
    }
  }

  void _navigateToMainMenu(BuildContext context) {
    Navigator.pushReplacement(
      context,
      FadeRoute(
        page: const MainMenuScreen(),
      ),
    );
  }
}
