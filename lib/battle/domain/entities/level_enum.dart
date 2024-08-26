import 'package:lg_flutter_hackathon/battle/domain/entities/bonus_entity.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/monster_entity.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';
import 'package:lg_flutter_hackathon/constants/strings.dart';

// TODO: set bonus strength
enum LevelEnum {
  first(
    MonsterEntity(
      speed: 25,
      healthPoints: 7 * 15,
      damage: 25,
      attackAnimation: 'goblin-attack',
      monsterName: 'Grunk the Less-Cute Troll',
    ),
    ImageAssets.trollBackground,
    [
      BonusEntity(type: BonusEnum.health, strength: 1),
      BonusEntity(type: BonusEnum.damage, strength: 1),
      BonusEntity(type: BonusEnum.time, strength: 1),
    ],
    ImageAssets.round1number,
    ImageAssets.trollEnemy,
    4,
    8,
    8,
  ),
  second(
    MonsterEntity(
      speed: 5,
      healthPoints: 37 * 14,
      damage: 11,
      attackAnimation: 'wolf-attack',
      monsterName: 'Pip and Squeak',
    ),
    ImageAssets.pipSqueakBackground,
    [
      BonusEntity(type: BonusEnum.health, strength: 2),
      BonusEntity(type: BonusEnum.damage, strength: 2),
      BonusEntity(type: BonusEnum.time, strength: 2),
    ],
    ImageAssets.round2number,
    ImageAssets.hopgoblinEnemy,
    1.7,
    12,
    12,
  ),
  third(
    MonsterEntity(
      speed: 30,
      healthPoints: 27 * 16,
      damage: 11,
      attackAnimation: 'bugbear-attack',
      monsterName: 'Jerry the Werewolf',
    ),
    ImageAssets.werewolfBackground,
    [
      BonusEntity(type: BonusEnum.health, strength: 3),
      BonusEntity(type: BonusEnum.damage, strength: 3),
      BonusEntity(type: BonusEnum.time, strength: 3),
    ],
    ImageAssets.round3number,
    ImageAssets.bugbearEnemy,
    1.5,
    10,
    10,
  ),
  fourth(
    MonsterEntity(
        speed: 40,
        healthPoints: 59 * 11,
        damage: 13,
        attackAnimation: 'ogre-attack',
        monsterName: 'Leviathus, the Crusher of Souls'),
    ImageAssets.leviathusBackground,
    // we don't display bonus screen after the final boss
    [],
    ImageAssets.round4number,
    ImageAssets.ogreEnemy,
    1.3,
    9,
    12,
  );

  const LevelEnum(
    this.monster,
    this.background,
    this.bonuses,
    this.roundAsset,
    this.monsterAsset,
    this.enemyScale,
    this.enemyBottomPositionBottom,
    this.enemyBottomPositionRight,
  );

  final MonsterEntity monster;
  final String background;
  final List<BonusEntity> bonuses;
  final String roundAsset;
  final String monsterAsset;
  final double enemyScale;
  final double enemyBottomPositionBottom;
  final double enemyBottomPositionRight;
}

String introDialog(LevelEnum level) => switch (level) {
  LevelEnum.first => Strings.enemy1IntroDialog,
  LevelEnum.second => Strings.enemy2IntroDialog,
  LevelEnum.third => Strings.enemy3IntroDialog,
  LevelEnum.fourth => Strings.enemy4IntroDialog,
};

String outroDialog(LevelEnum level) => switch (level) {
  LevelEnum.first => Strings.enemy1OutroDialog,
  LevelEnum.second => Strings.enemy2OutroDialog,
  LevelEnum.third => Strings.enemy3OutroDialog,
  LevelEnum.fourth => Strings.enemy4OutroDialog,
};

List<String> attackDialogs(LevelEnum level) => switch (level) {
  LevelEnum.first => Strings.enemy1AttackDialogs,
  LevelEnum.second => Strings.enemy2AttackDialogs,
  LevelEnum.third => Strings.enemy3AttackDialogs,
  LevelEnum.fourth => Strings.enemy4AttackDialogs,
};

List<String> defenseDialogs(LevelEnum level) => switch (level) {
  LevelEnum.first => Strings.enemy1DefenseDialogs,
  LevelEnum.second => Strings.enemy2DefenseDialogs,
  LevelEnum.third => Strings.enemy3DefenseDialogs,
  LevelEnum.fourth => Strings.enemy4DefenseDialogs,
};