import 'package:lg_flutter_hackathon/battle/domain/entities/monster_entity.dart';

enum LevelEnum {
  first(
    MonsterEntity(
      speed: 4,
      healthPoints: 7 * 15,
      damage: 25,
      background: 'goblin-background',
      attackAnimation: 'goblin-attack',
    ),
  ),
  second(
    MonsterEntity(
      speed: 50,
      healthPoints: 37 * 14,
      damage: 11,
      background: 'wolf-background',
      attackAnimation: 'wolf-attack',
    ),
  ),
  third(
    MonsterEntity(
      speed: 30,
      healthPoints: 27 * 16,
      damage: 11,
      background: 'bugbear-background',
      attackAnimation: 'bugbear-attack',
    ),
  ),
  fourth(
    MonsterEntity(
      speed: 40,
      healthPoints: 59 * 11,
      damage: 13,
      background: 'ogre-background',
      attackAnimation: 'ogre-attack',
    ),
  );

  const LevelEnum(this.monster);

  final MonsterEntity monster;
}
