import 'package:lg_flutter_hackathon/battle/domain/entities/monster_entity.dart';

enum LevelEnum {
  first(
    MonsterEntity(
      speed: 4,
      healthPoints: 7 * 15,
      damage: 25,
      attackAnimation: 'goblin-attack',
    ),
    'goblin-background',
  ),
  second(
      MonsterEntity(
        speed: 50,
        healthPoints: 37 * 14,
        damage: 11,
        attackAnimation: 'wolf-attack',
      ),
      'wolf-background'),
  third(
    MonsterEntity(
      speed: 30,
      healthPoints: 27 * 16,
      damage: 11,
      attackAnimation: 'bugbear-attack',
    ),
    'bugbear-background',
  ),
  fourth(
    MonsterEntity(
      speed: 40,
      healthPoints: 59 * 11,
      damage: 13,
      attackAnimation: 'ogre-attack',
    ),
    'ogre-background',
  );

  const LevelEnum(
    this.monster,
    this.background,
  );

  final MonsterEntity monster;
  final String background;
}
