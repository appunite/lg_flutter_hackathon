import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lg_flutter_hackathon/battle/domain/drawing_details_entity.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/level_enum.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/players_entity.dart';
import 'package:lg_flutter_hackathon/battle/presentation/cubit/battle_cubit.dart';
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
import 'package:pausable_timer/pausable_timer.dart';

class BattleScreen extends StatelessWidget {
  const BattleScreen({
    super.key,
    required this.level,
    required this.players,
  });

  final LevelEnum level;
  final PlayersEntity players;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BattleCubit(level, players),
      child: _BattleScreenBody(level, players),
    );
  }
}

class _BattleScreenBody extends StatefulWidget {
  const _BattleScreenBody(
    this.level,
    this.players,
  );

  final LevelEnum level;
  final PlayersEntity players;

  @override
  State<_BattleScreenBody> createState() => __BattleScreenBodyState();
}

class __BattleScreenBodyState extends State<_BattleScreenBody> with ReporterMixin {
  final TooltipController _controller = TooltipController();
  bool done = false;
  PausableTimer? _timer;

  bool isDrawing = false;
  double? accuracy;
  double overlayOpacity = 0.0;
  bool showAccuracyAnimation = false;

  double currentHealth = 100;
  double incomingHealth = 100;

  @override
  void initState() {
    super.initState();
    _controller.onDone(
      () => setState(() => done = true),
    );

    _startTimer(widget.level.monster.speed);
  }

  void _startTimer(int monsterSpeed) {
    _timer ??= PausableTimer.periodic(
      Duration(seconds: monsterSpeed),
      () {
        context.read<BattleCubit>().monsterAttack();
      },
    );
    _timer!.start();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return BlocConsumer<BattleCubit, BattleState>(
      listener: (context, state) {
        state.mapOrNull(
          monsterAttack: (_) => _monsterAttackAnimation(),
          playerAttack: (_) => _playersAttackAnimation(),
          gameOver: (_) => _openGameOverScreen(),
          victory: (_) => _openVictoryScreen(),
        );
      },
      builder: (context, state) {
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
                _buildPlayerIndicator(screenHeight, screenWidth),
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
      },
    );
  }

  Widget _buildPlayerHealthBar(double screenHeight, double screenWidth) {
    return Positioned(
      left: screenWidth / DesignConsts.playerHealthBarLeftFactor,
      top: screenHeight / DesignConsts.heightDivision32,
      child: BlocBuilder<BattleCubit, BattleState>(
        builder: (context, state) {
          return state.maybeMap(
            loaded: (result) => HealthBar(
              maxHealthPoints: widget.players.healthPoints,
              newHealthPoints: result.currentPlayersHealthPoints,
            ),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  Widget _buildPlayerIndicator(double screenHeight, double screenWidth) {
    return Positioned(
      left: screenWidth / DesignConsts.playerHealthBarLeftFactor,
      top: screenHeight / DesignConsts.heightDivision32 + 120,
      child: BlocBuilder<BattleCubit, BattleState>(
        builder: (context, state) {
          return state.maybeMap(
            loaded: (result) => Text(
              'Current player number = ${result.currentPlayerIndex + 1}',
            ),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  Widget _buildEnemyHealthBar(double screenHeight, double screenWidth) {
    return Positioned(
      right: screenWidth / DesignConsts.enemyHealthBarRightFactor,
      top: screenHeight / DesignConsts.heightDivision32,
      child: BlocBuilder<BattleCubit, BattleState>(
        builder: (context, state) {
          return state.maybeMap(
            loaded: (result) => HealthBar(
              maxHealthPoints: widget.level.monster.healthPoints,
              newHealthPoints: result.currentMonsterHealthPoints,
            ),
            orElse: () => const SizedBox.shrink(),
          );
        },
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
        info("Drawing completed with accuracy: ${details.toString()}");

        context.read<BattleCubit>().playerAttack(accuracy: details.accuracy);
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

  Widget _buildCentralButton(BuildContext context) => Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              isDrawing = true;
              overlayOpacity = 1.0;
              showAccuracyAnimation = false;
            });
          },
          child: const Text('Draw Rune'),
        ),
      );

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _monsterAttackAnimation() async {
    // TODO: Run monster attack animation
    print('TODO: Run monster attack animation');

    // TODO: Wait for monster attack animation
    Future.delayed(const Duration(seconds: 2)).then((val) {
      //context.read<BattleCubit>().gameOver();
    });
  }

  Future<void> _playersAttackAnimation() async {
    // TODO: Run players attack animation
    print('TODO: Run players attack animation');

    // TODO: Wait for player attack animation
    Future.delayed(const Duration(seconds: 2)).then((val) {
      //context.read<BattleCubit>().victory();
    });
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

  void _openGameOverScreen() {
    // TODO: Create game over screen
  }

  void _openVictoryScreen() {
    // TODO: Create victory over screen
  }
}
