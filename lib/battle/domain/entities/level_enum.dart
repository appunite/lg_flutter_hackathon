import 'package:lg_flutter_hackathon/battle/domain/entities/bonus_entity.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/monster_entity.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';

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
    'goblin-background',
    [
      BonusEntity(type: BonusEnum.health, strength: 1),
      BonusEntity(type: BonusEnum.damage, strength: 1),
      BonusEntity(type: BonusEnum.time, strength: 1),
    ],
    ImageAssets.round1number,
  ),
  second(
    MonsterEntity(
      speed: 5,
      healthPoints: 37 * 14,
      damage: 11,
      attackAnimation: 'wolf-attack',
      monsterName: 'Pip and Squeak',
    ),
    'wolf-background',
    [
      BonusEntity(type: BonusEnum.health, strength: 2),
      BonusEntity(type: BonusEnum.damage, strength: 2),
      BonusEntity(type: BonusEnum.time, strength: 2),
    ],
    ImageAssets.round2number,
  ),
  third(
    MonsterEntity(
      speed: 30,
      healthPoints: 27 * 16,
      damage: 11,
      attackAnimation: 'bugbear-attack',
      monsterName: 'Jerry the Werewolf',
    ),
    'bugbear-background',
    [
      BonusEntity(type: BonusEnum.health, strength: 3),
      BonusEntity(type: BonusEnum.damage, strength: 3),
      BonusEntity(type: BonusEnum.time, strength: 3),
    ],
    ImageAssets.round3number,
  ),
  fourth(
    MonsterEntity(
        speed: 40,
        healthPoints: 59 * 11,
        damage: 13,
        attackAnimation: 'ogre-attack',
        monsterName: 'Leviathus, the Crusher of Souls'),
    'ogre-background',
    // we don't display bonus screen after the final boss
    [],
    ImageAssets.round4number,
  );

  const LevelEnum(
    this.monster,
    this.background,
    this.bonuses,
    this.roundAsset,
  );

  final MonsterEntity monster;
  final String background;
  final List<BonusEntity> bonuses;
  final String roundAsset;
}
