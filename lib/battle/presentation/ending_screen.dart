import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lg_flutter_hackathon/audio/audio_controller.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/game_results_player_entity.dart';
import 'package:lg_flutter_hackathon/components/pushable_button.dart';
import 'package:lg_flutter_hackathon/constants/design_consts.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:lg_flutter_hackathon/constants/strings.dart';
import 'package:lg_flutter_hackathon/dependencies.dart';
import 'package:lg_flutter_hackathon/main_menu/main_menu_screen.dart';
import 'package:lg_flutter_hackathon/utils/storage.dart';
import 'package:lg_flutter_hackathon/utils/transitions.dart';

class EndGameScreen extends StatefulWidget {
  const EndGameScreen({
    super.key,
    required this.isVictory,
  });

  final bool isVictory;

  @override
  State<EndGameScreen> createState() => _EndGameScreenState();
}

class _EndGameScreenState extends State<EndGameScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Color?> _colorAnimation;
  late final Animation<double> _fontSizeAnimation;

  static const double _paddingFactor = 0.01;
  static const double _widthFactor = 0.5;
  static const double _aspectRatio = 1.0;
  static const double _fontSizeFactor = 0.02;
  static const double _headerFontSizeFactor = 0.025;
  static const double _playerCellHeightFactor = 0.1;
  static const double _playerCellWidthFactor = 0.15;
  static const double _playerIconHeightFactor = 0.07;
  static const double _playerIconLeftPaddingFactor = 0.03;
  static const double _playerNumberRightPaddingFactor = 0.075;

  List<GameResultPlayer> gameResults = [];

  final audioController = sl.get<AudioController>();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.yellow,
    ).animate(_controller);

    _fontSizeAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    loadGameResults();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      audioController.setSong(audioController.victorySong);
    });
  }

  Future<void> loadGameResults() async {
    final results = await sl<GameResultPlayerStorage>().getGameResultPlayer;
    setState(() {
      gameResults = results;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final containerWidth = screenWidth / 2;

    final maxAccuracyIndex = _findMaxAccuracyIndex(gameResults);

    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildGameResultHeader(screenWidth, screenHeight),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.25,
                left: containerWidth / 1.65,
                right: containerWidth / 1.65,
              ),
              child: _buildResultsTable(screenWidth, screenHeight, maxAccuracyIndex),
            ),
          ),
          Positioned(
            bottom: screenHeight / DesignConsts.buttonStartAgainBottomPositionFactor,
            left: screenWidth / DesignConsts.buttonStartAgainLeftRightPositionFactor,
            right: screenWidth / DesignConsts.buttonStartAgainLeftRightPositionFactor,
            child: PushableButton(
              onPressed: () {
                sl<GameResultPlayerStorage>().clear();
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  FadeRoute(
                    page: const MainMenuScreen(),
                  ),
                );
              },
              child: SvgPicture.asset(
                ImageAssets.playAgainButton,
                fit: BoxFit.contain,
                width: screenWidth / DesignConsts.playAgainWidthFactor,
                height: screenHeight / DesignConsts.playAgainHeightFactor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _findMaxAccuracyIndex(List<GameResultPlayer> gameResults) {
    double maxAccuracy = 0;
    int maxIndex = 0;
    for (int i = 0; i < gameResults.length; i++) {
      if (gameResults[i].averageAccuracy > maxAccuracy) {
        maxAccuracy = gameResults[i].averageAccuracy;
        maxIndex = i;
      }
    }
    return maxIndex;
  }

  Widget _buildBackground() {
    return SizedBox.expand(
      child: SvgPicture.asset(
        ImageAssets.gameStatsBackground,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildGameResultHeader(double screenWidth, double screenHeight) {
    return Positioned(
      top: screenHeight / 14,
      left: screenWidth / 4,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            ImageAssets.gameResultHolder,
            width: screenWidth / 2,
          ),
          Positioned(
            child: widget.isVictory
                ? ScaleTransition(
                    scale: _fontSizeAnimation,
                    child: Text(
                      Strings.congratulations,
                      style: TextStyle(
                        fontFamily: DesignConsts.fontFamily,
                        fontSize: screenHeight * 0.045,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Text(
                    Strings.gameOver,
                    style: TextStyle(
                      fontFamily: DesignConsts.fontFamily,
                      fontSize: screenHeight * 0.045,
                      color: Colors.white,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsTable(double screenWidth, double screenHeight, int maxAccuracyIndex) {
    return Table(
      columnWidths: {
        0: FlexColumnWidth(screenWidth * 0.003),
        1: FlexColumnWidth(screenWidth * 0.002),
        2: FlexColumnWidth(screenWidth * 0.002),
      },
      children: [
        _buildTableHeader(screenHeight),
        for (int i = 0; i < gameResults.length; i++) _buildTableRow(i, screenWidth, screenHeight, maxAccuracyIndex),
      ],
    );
  }

  TableRow _buildTableRow(int index, double screenWidth, double screenHeight, int maxAccuracyIndex) {
    return TableRow(
      children: [
        _buildPlayerCell(index, screenWidth, screenHeight),
        _buildStatCell(
          index,
          screenHeight,
          '${gameResults[index].averageAccuracy.toStringAsFixed(2)}%',
          isHighlighted: index == maxAccuracyIndex,
        ),
        _buildStatCell(
          index,
          screenHeight,
          '${gameResults[index].attackCount}',
          isHighlighted: false,
        ),
      ],
    );
  }

  TableRow _buildTableHeader(double screenHeight) {
    return TableRow(
      children: [
        _buildHeaderCell(Strings.player, screenHeight),
        _buildHeaderCell(Strings.avgAccuracy, screenHeight),
        _buildHeaderCell(Strings.attacks, screenHeight),
      ],
    );
  }

  Widget _buildHeaderCell(String title, double screenHeight) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(screenHeight * _paddingFactor),
        child: Text(
          title,
          style: TextStyle(
            fontSize: screenHeight * _headerFontSizeFactor,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: DesignConsts.fontFamily,
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerCell(int index, double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(screenHeight * _paddingFactor),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            _getPlayerBackground(index),
            fit: BoxFit.contain,
            height: screenHeight * _playerCellHeightFactor,
            width: screenHeight * _playerCellWidthFactor,
          ),
          Positioned(
            left: screenWidth * _playerIconLeftPaddingFactor,
            child: SvgPicture.asset(
              _getPlayerIcon(index),
              height: screenHeight * _playerIconHeightFactor,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            right: screenHeight * _playerNumberRightPaddingFactor,
            child: Text(
              '#${index + 1}',
              style: TextStyle(
                fontSize: screenHeight * _fontSizeFactor,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: DesignConsts.fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCell(int index, double screenHeight, String value, {required bool isHighlighted}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(screenHeight * _paddingFactor),
        child: FractionallySizedBox(
          widthFactor: _widthFactor,
          child: AspectRatio(
            aspectRatio: _aspectRatio,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SvgPicture.asset(
                    index == 0 ? ImageAssets.gameStatsPointFirstRow : ImageAssets.gameStatsPointSecondRow,
                    fit: BoxFit.contain,
                  ),
                ),
                Center(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Text(
                        value,
                        style: TextStyle(
                          fontSize: screenHeight * _fontSizeFactor,
                          fontFamily: DesignConsts.fontFamily,
                          color: isHighlighted ? _colorAnimation.value : Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getPlayerBackground(int index) {
    switch (index) {
      case 0:
        return ImageAssets.gameStatsPlayer1;
      case 1:
        return ImageAssets.gameStatsPlayer2;
      case 2:
        return ImageAssets.gameStatsPlayer3;
      case 3:
        return ImageAssets.gameStatsPlayer4;
      default:
        return ImageAssets.gameStatsPlayer1;
    }
  }

  String _getPlayerIcon(int index) {
    List<String> playerAssets = [
      ImageAssets.playerRed,
      ImageAssets.playerYellow,
      ImageAssets.playerGreen,
      ImageAssets.playerBlue,
    ];

    return playerAssets[index];
  }
}
