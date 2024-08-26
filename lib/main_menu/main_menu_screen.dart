import 'package:flutter/material.dart';

import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lg_flutter_hackathon/audio/audio_controller.dart';
import 'package:lg_flutter_hackathon/audio/sounds.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/level_enum.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/players_entity.dart';
import 'package:lg_flutter_hackathon/battle/presentation/battle_screen.dart';
import 'package:lg_flutter_hackathon/components/loading_screen.dart';
import 'package:lg_flutter_hackathon/components/pushable_button.dart';
import 'package:lg_flutter_hackathon/constants/design_consts.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';
import 'package:lg_flutter_hackathon/constants/strings.dart';
import 'package:lg_flutter_hackathon/dependencies.dart';
import 'package:provider/provider.dart';

import '../settings/settings.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();

    return _MainMenuBody(settingsController: settingsController);
  }
}

class _MainMenuBody extends StatefulWidget {
  const _MainMenuBody({
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  State<_MainMenuBody> createState() => __MainMenuBodyState();
}

class __MainMenuBodyState extends State<_MainMenuBody> {
  int _numberOfPlayers = 2;

  final List<bool> _isPlayerVisible = [true, true, false, false];

  final audioController = sl.get<AudioController>();

  void _incrementPlayers() {
    if (_numberOfPlayers < 4) {
      setState(() {
        _numberOfPlayers++;
        _isPlayerVisible[_numberOfPlayers - 1] = true;
      });
    }
  }

  void _decrementPlayers() {
    if (_numberOfPlayers > 2) {
      setState(() {
        _isPlayerVisible[_numberOfPlayers - 1] = false;
        _numberOfPlayers--;
      });
    }
  }

  List<Widget> _buildPlayersIcons(double width, double height) {
    List<String> playerAssets = [
      ImageAssets.playerBlue,
      ImageAssets.playerGreen,
      ImageAssets.playerYellow,
      ImageAssets.playerRed,
    ];

    List<String> nameAssets = [
      ImageAssets.playerBlueName,
      ImageAssets.playerGreenName,
      ImageAssets.playerYellowName,
      ImageAssets.playerRedName,
    ];

    return List<Widget>.generate(_numberOfPlayers, (index) {
      return AnimatedOpacity(
        opacity: _isPlayerVisible[index] ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 100),
              child: SvgPicture.asset(
                playerAssets[index],
                width: width / DesignConsts.playerIconWidthFactor,
                height: height / 5,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 100),
              child: SvgPicture.asset(
                nameAssets[index],
                height: height / 15,
                width: 100,
              ),
            ),
            SizedBox(height: height / 30),
            SizedBox(height: height / 20),
          ],
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      audioController.setSong(audioController.themeSong);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            SvgPicture.asset(
              ImageAssets.pickPlayersBackground,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: screenHeight / 10,
              left: screenWidth / DesignConsts.screenLeftRightPositionFactor,
              right: screenWidth / DesignConsts.screenLeftRightPositionFactor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _buildPlayersIcons(screenWidth, screenHeight),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        ImageAssets.pickPlayersContainer,
                        fit: BoxFit.contain,
                        width: screenWidth / DesignConsts.containerWidthFactor,
                        height: screenHeight / DesignConsts.containerHeightFactor,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Strings.numberOfPlayers,
                            style: TextStyle(
                              fontFamily: DesignConsts.fontFamily,
                              fontSize: screenWidth / DesignConsts.bonusTitleFontSizeFactor,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: screenHeight / DesignConsts.buttonSpacingFactor / 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PushableButton(
                                onPressed: _numberOfPlayers > 2 ? _decrementPlayers : null,
                                sfxType: SfxType.deletePlayerPop,
                                child: Opacity(
                                  opacity: _numberOfPlayers > 2 ? 1.0 : 0.5,
                                  child: SvgPicture.asset(
                                    ImageAssets.pickPlayersLeftButton,
                                    fit: BoxFit.contain,
                                    width: screenWidth / DesignConsts.buttonWidthFactor,
                                    height: screenHeight / DesignConsts.buttonHeightFactor,
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth / DesignConsts.buttonSpacingFactor),
                              Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        ImageAssets.pickPlayersNumbersContainer,
                                        fit: BoxFit.contain,
                                        width: screenWidth / DesignConsts.playerNumberContainerWidthFactor,
                                        height: screenHeight / DesignConsts.playerNumberContainerHeightFactor,
                                      ),
                                      Transform.translate(
                                        offset: const Offset(0, -6),
                                        child: Text(
                                          '$_numberOfPlayers',
                                          style: TextStyle(
                                            fontFamily: DesignConsts.fontFamily,
                                            fontSize: screenWidth / DesignConsts.numberFontSizeFactor,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: screenWidth / DesignConsts.buttonSpacingFactor),
                                ],
                              ),
                              SizedBox(width: screenWidth / DesignConsts.buttonSpacingFactor),
                              PushableButton(
                                onPressed: _numberOfPlayers < 4 ? _incrementPlayers : null,
                                sfxType: SfxType.addPlayerPop,
                                child: Opacity(
                                  opacity: _numberOfPlayers < 4 ? 1.0 : 0.5,
                                  child: SvgPicture.asset(
                                    ImageAssets.pickPlayersRightButton,
                                    fit: BoxFit.contain,
                                    width: screenWidth / DesignConsts.buttonWidthFactor,
                                    height: screenHeight / DesignConsts.buttonHeightFactor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight / DesignConsts.buttonSpacingFactor),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: screenHeight / 22,
              left: screenWidth / 2.3,
              right: screenWidth / 2.3,
              child: PushableButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoadingScreen(),
                    ),
                  );

                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BattleScreen(
                          level: LevelEnum.first,
                          players: PlayersEntity(healthPoints: 100, numberOfPlayers: 4, damage: 10),
                        ),
                      ),
                    );
                  });
                },
                child: SvgPicture.asset(
                  ImageAssets.pickPlayersAcceptButton,
                  fit: BoxFit.contain,
                  width: screenWidth / DesignConsts.acceptButtonWidthFactor,
                  height: screenHeight / DesignConsts.acceptButtonHeightFactor,
                ),
              ),
            ),
            Positioned(
              top: screenHeight / 40,
              left: screenWidth / 40,
              child: soundSettings(widget.settingsController, screenWidth),
            ),
          ],
        ),
      ),
    );
  }

  Widget soundSettings(SettingsController settingsController, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: settingsController.musicOn,
          builder: (context, musicOn, child) {
            return IconButton(
              onPressed: settingsController.toggleMusicOn,
              icon: Icon(
                musicOn ? Icons.volume_up : Icons.volume_off,
                size: screenWidth / DesignConsts.iconSizeFactor,
              ),
              color: Colors.white,
            );
          },
        ),
        const SizedBox(width: 32),
        ValueListenableBuilder<bool>(
          valueListenable: settingsController.soundsOn,
          builder: (context, soundsOn, child) {
            return IconButton(
              onPressed: settingsController.toggleSoundsOn,
              icon: Icon(
                soundsOn ? Icons.music_note : Icons.music_off,
                size: screenWidth / DesignConsts.iconSizeFactor,
              ),
              color: Colors.white,
            );
          },
        ),
      ],
    );
  }
}
