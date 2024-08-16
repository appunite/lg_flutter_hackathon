import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lg_flutter_hackathon/components/pushable_button.dart';
import 'package:lg_flutter_hackathon/constants/design_consts.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';
import 'package:lg_flutter_hackathon/constants/strings.dart';
import 'package:provider/provider.dart';
import '../settings/settings.dart';

import 'package:flutter_svg/flutter_svg.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  int _numberOfPlayers = 2;

  final List<bool> _isPlayerVisible = [true, true, false, false];

  void _incrementPlayers() {
    setState(() {
      if (_numberOfPlayers < 4) {
        _numberOfPlayers++;
        _isPlayerVisible[_numberOfPlayers - 1] = true;
      }
    });
  }

  void _decrementPlayers() {
    setState(() {
      if (_numberOfPlayers > 2) {
        _isPlayerVisible[_numberOfPlayers - 1] = false;
        _numberOfPlayers--;
      }
    });
  }

  List<Widget> _buildPlayersIcons(double width, double height) {
    List<String> playerAssets = [
      ImageAssets.playerRed,
      ImageAssets.playerYellow,
      ImageAssets.playerGreen,
      ImageAssets.playerBlue,
    ];

    return List<Widget>.generate(4, (index) {
      return AnimatedOpacity(
        opacity: _isPlayerVisible[index] ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: SvgPicture.asset(
          playerAssets[index],
          width: width / DesignConsts.playerIconWidthFactor,
          height: height / DesignConsts.playerIconHeightFactor,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    final settingsController = context.watch<SettingsController>();

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
              bottom: screenHeight / DesignConsts.screenBottomPositionFactor,
              left: screenWidth / DesignConsts.screenLeftRightPositionFactor,
              right: screenWidth / DesignConsts.screenLeftRightPositionFactor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                              fontFamily: 'Knewave',
                              fontSize: screenWidth / DesignConsts.titleFontSizeFactor,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PushableButton(
                                onPressed: _numberOfPlayers > 2 ? _decrementPlayers : () {},
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
                                            fontFamily: 'Knewave',
                                            fontSize: screenWidth / DesignConsts.numberFontSizeFactor,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: screenWidth / DesignConsts.buttonSpacingFactor),
                              PushableButton(
                                onPressed: _numberOfPlayers < 4 ? _incrementPlayers : () {},
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
                          SizedBox(height: screenHeight / DesignConsts.acceptButtonSpacingFactor),
                          PushableButton(
                            onPressed: () => Navigator.pushNamed(context, '/battle'),
                            child: SvgPicture.asset(
                              ImageAssets.pickPlayersAcceptButton,
                              fit: BoxFit.contain,
                              width: screenWidth / DesignConsts.acceptButtonWidthFactor,
                              height: screenHeight / DesignConsts.acceptButtonHeightFactor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenHeight / 40,
              left: screenWidth / 40,
              child: soundSettings(settingsController),
            ),
          ],
        ),
      ),
    );
  }

  Widget soundSettings(SettingsController settingsController) {
    final screenWidth = MediaQuery.sizeOf(context).width;

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
