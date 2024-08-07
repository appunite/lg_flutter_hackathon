import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lg_flutter_hackathon/battle/domain/drawing_details_entity.dart';
import 'package:lg_flutter_hackathon/battle/domain/glyph_entity.dart';
import 'package:lg_flutter_hackathon/battle/presentation/widgets/accuracy_animted_text.dart';
import 'package:lg_flutter_hackathon/battle/presentation/widgets/drawing_overlay.dart';
import 'package:lg_flutter_hackathon/components/confirmation_pop_up.dart';
import 'package:lg_flutter_hackathon/components/tool_tip.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';
import 'package:lg_flutter_hackathon/constants/strings.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';

import 'package:flutter_svg/flutter_svg.dart';

class BattleScreen extends StatefulWidget {
  const BattleScreen({super.key});

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  final TooltipController _controller = TooltipController();
  bool done = false;
  bool canDraw = true;
  double? accuracy;

  @override
  void initState() {
    _controller.onDone(() {
      setState(() {
        done = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayTooltipScaffold(
      overlayColor: Colors.red.withOpacity(.4),
      tooltipAnimationCurve: Curves.linear,
      tooltipAnimationDuration: const Duration(milliseconds: 1000),
      controller: _controller,
      preferredOverlay: GestureDetector(
        onTap: () {
          _controller.next();
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.blue.withOpacity(.2),
        ),
      ),
      builder: (context) => Scaffold(
        body: Stack(
          children: [
            _buildBackground(),
            _buildRune(context),
            _buildPlayer(),
            _buildEnemy(),
            _buildStartButton(context),
            _buildSettingsButton(context),
            Positioned(
              top: MediaQuery.of(context).size.height / 5,
              left: MediaQuery.of(context).size.width / 2,
              child: AccuracyAnimatedText(accuracy: accuracy),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return SvgPicture.asset(
      ImageAssets.battleBackground,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      placeholderBuilder: (BuildContext context) => const SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildRune(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final drawingAreaHeight = screenHeight / 3;
    const glyphSize = 250.0;

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: screenHeight / 10),
        child: OverlayTooltipItem(
          displayIndex: 1,
          tooltip: (controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: MTooltip(title: 'This is the rune!', controller: controller),
            );
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                ImageAssets.stoneDrawingHolder,
                fit: BoxFit.cover,
                height: drawingAreaHeight,
                placeholderBuilder: (BuildContext context) => const SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              ),
              if (canDraw)
                _buildDrawingOverlay(
                  context,
                  glyphSize,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawingOverlay(BuildContext context, double glyphSize) {
    return SizedBox(
      width: glyphSize,
      height: glyphSize,
      child: DrawingOverlay(
        onDrawingCompleted: (DrawingDetails details) {
          setState(() {
            accuracy = details.accuracy;
          });
          // ignore: avoid_print
          print(details);
        },
        thresholdPercentage: 0.9,
        glyphAsset: GlyphEntity(
          glyphCompare: ImageAssets.glyphCompare,
          glyphPresentation: ImageAssets.glyphPresentation,
        ),
        drawingAreaSize: glyphSize,
      ),
    );
  }

  Widget _buildPlayer() {
    return Positioned(
      bottom: 20,
      left: 20,
      child: OverlayTooltipItem(
        displayIndex: 0,
        tooltip: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: MTooltip(title: 'this is the player!', controller: controller),
          );
        },
        child: SvgPicture.asset(
          height: MediaQuery.sizeOf(context).height / 3,
          ImageAssets.players,
          fit: BoxFit.cover,
          placeholderBuilder: (BuildContext context) => const SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Widget _buildEnemy() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: OverlayTooltipItem(
        displayIndex: 2,
        tooltip: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MTooltip(title: 'kill dis!', controller: controller),
          );
        },
        child: SvgPicture.asset(
          height: MediaQuery.sizeOf(context).height / 4,
          ImageAssets.trollEnemy,
          fit: BoxFit.cover,
          placeholderBuilder: (BuildContext context) => const SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return Positioned(
      bottom: 80,
      left: MediaQuery.of(context).size.width / 2 - 75,
      child: TextButton(
        onPressed: () {
          _controller.start();
          OverlayTooltipScaffold.of(context)?.controller.start();
        },
        child: const Text('Start Tooltip manually'),
      ),
    );
  }

  Widget _buildSettingsButton(BuildContext context) {
    return IconButton(
      onPressed: () => showDialog(
        context: context,
        builder: (context) {
          return const ConfirmationPopUp(title: Strings.exitConfirmation);
        },
      ),
      icon: const Icon(Icons.settings),
    );
  }
}
