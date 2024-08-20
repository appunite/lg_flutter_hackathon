import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/bonus_entity.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/level_enum.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/players_entity.dart';
import 'package:lg_flutter_hackathon/battle/presentation/battle_screen.dart';
import 'package:lg_flutter_hackathon/components/pushable_button.dart';
import 'package:lg_flutter_hackathon/constants/design_consts.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';

class BonusesScreen extends StatefulWidget {
  const BonusesScreen({
    super.key,
    required this.level,
    required this.players,
  });

  final LevelEnum level;
  final PlayersEntity players;

  @override
  State<BonusesScreen> createState() => _BonusesScreenState();
}

class _BonusesScreenState extends State<BonusesScreen> {
  late final CarouselController _carouselController;
  late BonusEntity _currentBonus = widget.level.bonuses.first;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              ImageAssets.bonusesBackground,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: screenHeight / DesignConsts.bonusStandHeightFactor,
              left: screenWidth / DesignConsts.screenLeftRightPositionFactor,
              right: screenWidth / DesignConsts.screenLeftRightPositionFactor,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  _bonusStand(screenWidth, screenHeight),
                  _bonusesCarousel(screenHeight, screenWidth),
                  _bonusDescription(screenHeight, screenWidth),
                  _arrowButtons(screenHeight, screenWidth),
                ],
              ),
            ),
            _okButton(screenWidth, context),
            _title(screenWidth),
          ],
        ),
      ),
    );
  }

  SvgPicture _bonusStand(double screenWidth, double screenHeight) {
    return SvgPicture.asset(
      ImageAssets.bonusesStand,
      fit: BoxFit.contain,
      width: screenWidth / DesignConsts.standWidthFactor,
      height: screenHeight / DesignConsts.standHeightFactor,
    );
  }

  Positioned _bonusesCarousel(double screenHeight, double screenWidth) {
    return Positioned(
      bottom: screenWidth / DesignConsts.bonusCarouselHeightFactor + 5,
      child: SizedBox(
        height: screenHeight / 3,
        width: screenWidth / DesignConsts.bonusesWidthFactor,
        child: CarouselSlider(
          carouselController: _carouselController,
          items: widget.level.bonuses
              .map(
                (bonus) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      SvgPicture.asset(
                        bonus.type.imagePath,
                        alignment: Alignment.bottomCenter,
                        height: screenHeight / 4,
                        width: screenWidth / 4,
                      ),
                      if (_currentBonus == bonus)
                        Text(
                          '+${bonus.strength}',
                          style: const TextStyle(
                            fontFamily: DesignConsts.fontFamily,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                    ],
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
            viewportFraction: 0.35,
            enableInfiniteScroll: true,
            aspectRatio: 1 / 2,
            enlargeCenterPage: true,
            enlargeFactor: 0.5,
            onPageChanged: (index, reason) {
              setState(() {
                _currentBonus = widget.level.bonuses[index];
              });
            },
          ),
        ),
      ),
    );
  }

  Positioned _bonusDescription(double screenHeight, double screenWidth) {
    return Positioned(
      bottom: screenHeight / DesignConsts.bonusDescriptionHeightFactor - 5,
      child: Text(
        '+${_currentBonus.strength}${_currentBonus.type.description}',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: DesignConsts.fontFamily,
          fontSize: screenWidth / DesignConsts.bonusDescriptionFontSizeFactor,
          color: Colors.white,
        ),
      ),
    );
  }

  Positioned _arrowButtons(double screenHeight, double screenWidth) {
    return Positioned(
      bottom: screenHeight / DesignConsts.bonusArrowsHeightFactor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PushableButton(
            child: SvgPicture.asset(
              ImageAssets.pickPlayersLeftButton,
              fit: BoxFit.contain,
              width: screenWidth / DesignConsts.bonusButtonFactor,
              height: screenHeight / DesignConsts.bonusButtonFactor,
            ),
            onPressed: () {
              _carouselController.previousPage();
            },
          ),
          SizedBox(width: screenWidth / DesignConsts.bonusesButtonsSpaceFactor),
          PushableButton(
            child: SvgPicture.asset(
              ImageAssets.pickPlayersRightButton,
              fit: BoxFit.contain,
              width: screenWidth / DesignConsts.bonusButtonFactor,
              height: screenHeight / DesignConsts.bonusButtonFactor,
            ),
            onPressed: () {
              _carouselController.nextPage();
            },
          )
        ],
      ),
    );
  }

  Positioned _title(double screenWidth) {
    return Positioned(
      top: 60,
      child: Text(
        'Choose your bonus!',
        style: TextStyle(
          fontFamily: DesignConsts.fontFamily,
          fontSize: screenWidth / DesignConsts.bonusTitleFontSizeFactor,
          color: Colors.white,
        ),
      ),
    );
  }

  Positioned _okButton(double screenWidth, BuildContext context) {
    return Positioned(
      bottom: 20,
      child: PushableButton(
        child: SvgPicture.asset(
          ImageAssets.okButton,
          fit: BoxFit.contain,
          height: screenWidth / DesignConsts.bonusOkButtonFactor,
          width: screenWidth / DesignConsts.bonusOkButtonFactor,
        ),
        onPressed: () {
          //TODO: navigate to the next round
          final currentLevelIndex = LevelEnum.values.indexOf(widget.level);
          if (currentLevelIndex == 3) {
            //TODO go to game summary
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BattleScreen(
                  level: LevelEnum.values[currentLevelIndex + 1],
                  players: widget.players,
                  chosenBonus: _currentBonus,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
