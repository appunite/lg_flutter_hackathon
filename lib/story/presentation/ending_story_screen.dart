import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lg_flutter_hackathon/audio/audio_controller.dart';
import 'package:lg_flutter_hackathon/battle/presentation/ending_screen.dart';
import 'package:lg_flutter_hackathon/constants/design_consts.dart';
import 'package:lg_flutter_hackathon/dependencies.dart';
import 'package:lg_flutter_hackathon/story/domain/ending_story_enum.dart';
import 'package:lg_flutter_hackathon/story/presentation/widgets/story_text_container.dart';
import 'package:lg_flutter_hackathon/utils/transitions.dart';

class EndingStoryScreen extends StatefulWidget {
  const EndingStoryScreen({
    super.key,
    required this.step,
  });

  final EndingStoryStep step;

  @override
  State<EndingStoryScreen> createState() => _EndingStoryScreenState();
}

class _EndingStoryScreenState extends State<EndingStoryScreen> {
  final audioController = sl.get<AudioController>();

  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration(seconds: widget.step.displayDuration),
      () => _navigateToNextStep(context),
    );

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      audioController.setSong(audioController.victorySong);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              widget.step.backgroundPath,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: screenHeight / DesignConsts.storyScreenBottomPositionFactor,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                StoryTextContainer(text: widget.step.text),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToNextStep(BuildContext context) {
    final currentIndex = EndingStoryStep.values.indexOf(widget.step);
    if (currentIndex == EndingStoryStep.values.length - 1) {
      _navigateToStats(context);
    } else {
      Navigator.pushReplacement(
        context,
        FadeRoute(
          page: EndingStoryScreen(
            step: EndingStoryStep.values[currentIndex + 1],
          ),
        ),
      );
    }
  }

  void _navigateToStats(BuildContext context) {
    Navigator.pushReplacement(
      context,
      FadeRoute(
        page: const EndGameScreen(
          isVictory: true,
        ),
      ),
    );
  }
}
