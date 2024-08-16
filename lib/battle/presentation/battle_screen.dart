import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lg_flutter_hackathon/battle/domain/drawing_details_entity.dart';
import 'package:lg_flutter_hackathon/battle/presentation/widgets/accuracy_animated_text.dart';
import 'package:lg_flutter_hackathon/battle/presentation/widgets/debug_bar.dart';
import 'package:lg_flutter_hackathon/battle/presentation/widgets/drawing_overlay.dart';
import 'package:lg_flutter_hackathon/battle/presentation/widgets/health_bar.dart';
import 'package:lg_flutter_hackathon/components/confirmation_pop_up.dart';
import 'package:lg_flutter_hackathon/components/tool_tip.dart';
import 'package:lg_flutter_hackathon/constants/design_consts.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';
import 'package:lg_flutter_hackathon/constants/strings.dart';
import 'package:lg_flutter_hackathon/logger.dart';
import 'package:lg_flutter_hackathon/utils/drawing_utils.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';

import 'package:flutter_svg/flutter_svg.dart';

class BattleScreen extends StatefulWidget {
  const BattleScreen({super.key});

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> with ReporterMixin {
  final TooltipController _controller = TooltipController();
  bool done = false;

  bool isDrawing = false;
  double? accuracy;
  double overlayOpacity = 0.0;
  bool showAccuracyAnimation = false;

  double currentHealth = 100;
  double incomingHealth = 100;

  @override
  void initState() {
    _controller.onDone(
      () => setState(() => done = true),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return OverlayTooltipScaffold(
      overlayColor: Colors.red.withOpacity(.4),
      tooltipAnimationCurve: Curves.linear,
      tooltipAnimationDuration: const Duration(milliseconds: 1000),
      controller: _controller,
      preferredOverlay: GestureDetector(
        onTap: () => _controller.next(),
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
            _buildPlayerHealthBar(screenHeight, screenWidth),
            _buildEnemyHealthBar(screenHeight, screenWidth),
            _buildPlayer(screenHeight, screenWidth),
            _buildEnemy(screenHeight, screenWidth),
            _buildSettingsButton(context),
            AnimatedOpacity(
              opacity: overlayOpacity,
              duration: const Duration(milliseconds: 500),
              child: isDrawing ? _buildDrawingOverlayContent(context, 250) : const SizedBox.shrink(),
            ),
            if (showAccuracyAnimation && accuracy != null)
              Positioned(
                top: screenHeight * 0.2,
                left: 0,
                right: 0,
                child: Center(
                  child: AnimatedAccuracyText(accuracy: accuracy),
                ),
              ),
            DebugBar(
              onSimulateDamage: _simulateDamage,
              onDrawRune: _simulateDrawRune,
              onSimulateHealthGain: _simulateHealthGain,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerHealthBar(double screenHeight, double screenWidth) {
    return Positioned(
      left: screenWidth / DesignConsts.playerHealthBarLeftFactor,
      top: screenHeight / DesignConsts.heightDivision32,
      child: HealthBar(
        currentHealth: currentHealth,
        incomingHealth: incomingHealth,
      ),
    );
  }

  Widget _buildEnemyHealthBar(double screenHeight, double screenWidth) {
    return Positioned(
      right: screenWidth / DesignConsts.enemyHealthBarRightFactor,
      top: screenHeight / DesignConsts.heightDivision32,
      child: HealthBar(
        currentHealth: currentHealth,
        incomingHealth: incomingHealth,
      ),
    );
  }

  Widget _buildBackground() {
    return SizedBox.expand(
      child: SvgPicture.asset(
        ImageAssets.battleBackground,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildDrawingOverlayContent(BuildContext context, double glyphSize) {
    return DrawingOverlay(
      onDrawingCompleted: (DrawingDetails details) {
        setState(() {
          accuracy = details.accuracy;
          overlayOpacity = 0.0;
          isDrawing = false;
          showAccuracyAnimation = true;
        });
        info("Drawing completed with accuracy: ${details.accuracy}");
      },
      thresholdPercentage: 0.9,
      glyphAsset: DrawingUtils().getRandomGlyphEntity(),
      drawingAreaSize: glyphSize,
    );
  }

  Widget _buildPlayer(double screenHeight, double screenWidth) {
    return Positioned(
      bottom: screenHeight / DesignConsts.playerBottomPositionFactor,
      left: screenWidth / DesignConsts.widthDivisionForPlayer,
      child: OverlayTooltipItem(
        displayIndex: 0,
        tooltip: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: MTooltip(
              title: 'this is the player!',
              controller: controller,
            ),
          );
        },
        child: SvgPicture.asset(
          height: screenHeight / 2,
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

  Widget _buildEnemy(double screenHeight, double screenWidth) {
    return Positioned(
      bottom: screenHeight / DesignConsts.playerBottomPositionFactor,
      right: screenWidth / DesignConsts.widthDivisionForPlayer,
      child: OverlayTooltipItem(
        displayIndex: 2,
        tooltip: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MTooltip(title: 'kill dis!', controller: controller),
          );
        },
        child: SvgPicture.asset(
          height: screenHeight / 4,
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

  Widget _buildSettingsButton(BuildContext context) {
    return IconButton(
      onPressed: () => showDialog(
        context: context,
        builder: (context) => const ConfirmationPopUp(
          title: Strings.exitConfirmation,
        ),
      ),
      icon: const Icon(
        Icons.settings,
        color: Colors.white,
      ),
    );
  }

  void _simulateDrawRune() {
    setState(() {
      isDrawing = true;
      overlayOpacity = 1.0;
      showAccuracyAnimation = false;
    });
  }

  void _simulateDamage() {
    setState(() {
      final random = Random();
      incomingHealth = max(0, currentHealth - random.nextInt(20) - 5);
      currentHealth = incomingHealth;
    });
  }

  void _simulateHealthGain() {
    setState(() {
      final random = Random();
      incomingHealth = min(100, currentHealth + random.nextInt(20) + 5);
      currentHealth = incomingHealth;
    });
  }
}
