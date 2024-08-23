import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/bonus_entity.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/drawing_details_entity.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/drawing_mode_enum.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/level_enum.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/players_entity.dart';
import 'package:lg_flutter_hackathon/battle/presentation/cubit/battle_cubit.dart';
import 'package:lg_flutter_hackathon/battle/presentation/ending_screen.dart';
import 'package:lg_flutter_hackathon/battle/presentation/widgets/accuracy_animated_text.dart';
import 'package:lg_flutter_hackathon/battle/presentation/widgets/drawing_overlay.dart';
import 'package:lg_flutter_hackathon/battle/presentation/widgets/health_bar.dart';
import 'package:lg_flutter_hackathon/battle/presentation/widgets/round_widget.dart';
import 'package:lg_flutter_hackathon/bonuses/bonuses_screen.dart';
import 'package:lg_flutter_hackathon/components/confirmation_pop_up.dart';
import 'package:lg_flutter_hackathon/components/tool_tip.dart';
import 'package:lg_flutter_hackathon/constants/design_consts.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';
import 'package:lg_flutter_hackathon/constants/strings.dart';
import 'package:lg_flutter_hackathon/logger.dart';
import 'package:lg_flutter_hackathon/settings/settings.dart';
import 'package:lg_flutter_hackathon/story/domain/ending_story_enum.dart';
import 'package:lg_flutter_hackathon/story/presentation/ending_story_screen.dart';
import 'package:lg_flutter_hackathon/utils/drawing_utils.dart';
import 'package:lg_flutter_hackathon/utils/transitions.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';
import 'package:pausable_timer/pausable_timer.dart';

class BattleScreen extends StatelessWidget {
  const BattleScreen({
    super.key,
    required this.level,
    required this.players,
    this.chosenBonus,
  });

  final LevelEnum level;
  final PlayersEntity players;
  final BonusEntity? chosenBonus;

  @override
  Widget build(BuildContext context) {
    final playersWithBonuses = players.copyWith(
      healthPoints:
          chosenBonus?.type == BonusEnum.health ? players.healthPoints + chosenBonus!.strength : players.healthPoints,
      damage: chosenBonus?.type == BonusEnum.damage ? players.damage + chosenBonus!.strength : players.damage,
    );

    return BlocProvider(
      create: (context) => BattleCubit(
        level,
        playersWithBonuses,
      ),
      child: _BattleScreenBody(level, playersWithBonuses, chosenBonus),
    );
  }
}

class _BattleScreenBody extends StatefulWidget {
  const _BattleScreenBody(
    this.level,
    this.players,
    this.chosenBonus,
  );

  final LevelEnum level;
  final PlayersEntity players;
  final BonusEntity? chosenBonus;

  @override
  State<_BattleScreenBody> createState() => __BattleScreenBodyState();
}

class __BattleScreenBodyState extends State<_BattleScreenBody> with ReporterMixin {
  final TooltipController _toolTipController = TooltipController();

  PausableTimer? _timer;
  bool _shouldMonsterAttack = false;

  bool _isDrawing = false;
  double? _accuracy;
  double _overlayOpacity = 0.0;
  bool _showAccuracyAnimation = false;
  DrawingModeEnum _currentDrawingMode = DrawingModeEnum.attack;
  bool _showTutorial = false;

  @override
  void initState() {
    super.initState();

    _toolTipController.onDone(
      () {
        _drawRune(DrawingModeEnum.attack);
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 4));
      //start tutorial or game
      if (_showTutorial) {
        _toolTipController.start();
      } else {
        _startTimer(widget.level.monster.speed, widget.chosenBonus);
        _drawRune(DrawingModeEnum.attack);
      }
    });
  }

  void _startTimer(int monsterSpeed, BonusEntity? bonus) {
    int seconds = monsterSpeed;

    // apply time bonus
    if (bonus != null && bonus.type == BonusEnum.time) {
      seconds += bonus.strength;
    }

    _timer ??= PausableTimer.periodic(
      Duration(seconds: seconds),
      () {
        _shouldMonsterAttack = true;
        _timer?.pause();
      },
    );
    _timer!.start();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final settingsController = context.watch<SettingsController>();

    return ValueListenableBuilder<bool>(
      valueListenable: settingsController.tutorial,
      builder: (context, showTutorial, _) {
        _showTutorial = showTutorial;

        return BlocConsumer<BattleCubit, BattleState>(
          listener: (context, state) {
            state.mapOrNull(
              loaded: (result) {
                if (result.currentMonsterHealthPoints <= 0) {
                  _openVictoryScreen();
                } else if (result.currentPlayersHealthPoints <= 0) {
                  _openGameOverScreen();
                }
              },
              monsterAttack: (_) => _monsterAttackAnimation(),
              playerAttack: (_) => _playersAttackAnimation(),
            );
          },
          builder: (context, state) {
            return OverlayTooltipScaffold(
              tooltipAnimationCurve: Curves.linear,
              tooltipAnimationDuration: const Duration(milliseconds: 1000),
              controller: _toolTipController,
              preferredOverlay: GestureDetector(
                onTap: () => _toolTipController.next(),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              builder: (context) => Scaffold(
                body: RoundWidget(
                  level: widget.level,
                  child: Stack(
                    children: [
                      _buildBackground(),
                      _buildPlayerHealthBar(screenHeight, screenWidth),
                      _buildEnemyHealthBar(screenHeight, screenWidth),
                      _buildPlayer(screenHeight, screenWidth),
                      _buildEnemy(screenHeight, screenWidth),
                      _buildSettingsButton(context),
                      AnimatedOpacity(
                        opacity: _overlayOpacity,
                        duration: const Duration(milliseconds: 500),
                        child: _isDrawing
                            ? _buildDrawingOverlayContent(context, 250, _showTutorial, settingsController)
                            : const SizedBox.shrink(),
                      ),
                      if (_showAccuracyAnimation && _accuracy != null)
                        Positioned(
                          top: screenHeight * 0.2,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: AnimatedAccuracyText(accuracy: _accuracy),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
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
            loaded: (result) {
              double healthPoints = widget.players.healthPoints;

              // apply health bonus
              if (widget.chosenBonus?.type == BonusEnum.health) {
                healthPoints += widget.chosenBonus!.strength.toDouble();
              }

              return OverlayTooltipItem(
                displayIndex: 0,
                tooltip: (controller) {
                  return MTooltip(title: 'Welcome to the tutorial! This is your health bar', controller: controller);
                },
                child: HealthBar(
                  maxHealthPoints: healthPoints,
                  newHealthPoints: result.currentPlayersHealthPoints,
                ),
              );
            },
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
            loaded: (result) => OverlayTooltipItem(
              displayIndex: 1,
              tooltip: (controller) {
                return MTooltip(title: 'And this is the enemies health bar!', controller: controller);
              },
              child: HealthBar(
                maxHealthPoints: widget.level.monster.healthPoints,
                newHealthPoints: result.currentMonsterHealthPoints,
              ),
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

  Widget _buildDrawingOverlayContent(
    BuildContext context,
    double glyphSize,
    bool showTutorial,
    SettingsController settingsController,
  ) {
    return BlocBuilder<BattleCubit, BattleState>(
      builder: (context, state) {
        return state.maybeMap(
          loaded: (result) => DrawingOverlay(
            onDrawingCompleted: (DrawingDetails details) {
              setState(() {
                _accuracy = details.accuracy;
                _overlayOpacity = 0.0;
                _isDrawing = false;
                _showAccuracyAnimation = true;
              });
              info("Drawing completed with accuracy: ${details.toString()}");

              if (_currentDrawingMode == DrawingModeEnum.attack) {
                context.read<BattleCubit>().playerAttack(accuracy: details.accuracy);
              } else {
                context.read<BattleCubit>().monsterAttack(accuracy: details.accuracy);
              }
            },
            tutorialFinished: (value) async {
              setState(() {
                settingsController.showTutorial(!value);
                _showTutorial = false;
              });
              // start drawing after tutorial ends
              _startTimer(widget.level.monster.speed, widget.chosenBonus);
            },
            tutorial: showTutorial,
            thresholdPercentage: 0.9,
            glyphAsset: DrawingUtils().getRandomGlyphEntity(),
            drawingAreaSize: glyphSize,
            drawingMode: _currentDrawingMode,
            currentPlayerIndex: result.currentPlayerIndex,
          ),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildPlayer(double screenHeight, double screenWidth) {
    return Positioned(
      bottom: screenHeight / DesignConsts.playerBottomPositionFactor,
      left: screenWidth / DesignConsts.widthDivisionForPlayer,
      child: OverlayTooltipItem(
        displayIndex: 2,
        tooltipVerticalPosition: TooltipVerticalPosition.TOP,
        tooltip: (controller) {
          return MTooltip(
            title:
                'You will be taking turns on attacking the enemy! After each attack pass the remote to the next player',
            controller: controller,
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
        displayIndex: 3,
        tooltip: (controller) {
          return MTooltip(title: 'You have to defeat him! he\'s blocking your way!', controller: controller);
        },
        tooltipVerticalPosition: TooltipVerticalPosition.TOP,
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

  @override
  void dispose() {
    _toolTipController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _monsterAttackAnimation() async {
    // TODO: Run monster attack animation
    // ignore: avoid_print
    print('TODO: Run monster attack animation');

    print('TODO: Wait for monster attack animation end');
    Future.delayed(
      const Duration(seconds: 2),
      () {
        _nextTurn();
      },
    );

    // TODO: Wait for monster attack animation
    Future.delayed(const Duration(seconds: 2)).then((val) {
      //context.read<BattleCubit>().gameOver();
    });
  }

  Future<void> _playersAttackAnimation() async {
    // TODO: Run players attack animation
    // ignore: avoid_print
    print('TODO: Run players attack animation');

    print('TODO: Wait for players attack animation end');
    Future.delayed(
      const Duration(seconds: 2),
      () {
        _nextTurn();
      },
    );

    // TODO: Wait for player attack animation
  }

  void _nextTurn() {
    if (_shouldMonsterAttack) {
      _drawRune(DrawingModeEnum.defence);

      _timer?.start();
      setState(() {
        _shouldMonsterAttack = false;
      });
    } else {
      _drawRune(DrawingModeEnum.attack);
    }
  }

  void _drawRune(DrawingModeEnum drawingMode) {
    setState(() {
      _isDrawing = true;
      _overlayOpacity = 1.0;
      _showAccuracyAnimation = false;
      _currentDrawingMode = drawingMode;
    });
  }

  void _openGameOverScreen() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
          context,
          FadeRoute(
            page: const EndGameScreen(
              isVictory: false,
            ),
          ),
        );
      },
    );
  }

  void _openVictoryScreen() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (widget.level == LevelEnum.fourth) {
          Navigator.pushReplacement(
            context,
            FadeRoute(
              page: const EndingStoryScreen(
                step: EndingStoryStep.fountain,
              ),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            FadeRoute(
              page: BonusesScreen(
                players: widget.players,
                level: widget.level,
              ),
            ),
          );
        }
      },
    );
  }
}
