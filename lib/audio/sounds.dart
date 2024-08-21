List<String> soundTypeToFilename(SfxType type) => switch (type) {
      SfxType.buttonTap => const ['sh1.mp3'],
      SfxType.addPlayerPop => const ['add_player_pop.mp3'],
      SfxType.deletePlayerPop => const ['delete_player_pop.mp3'],
      SfxType.drawing => const ['drawingPen.mp3'],
      //TODO: add when eney attacks
      SfxType.punch => const ['punch.mp3'],
      SfxType.scratch => const ['scratch.mp3'],
      //TODO: add when player dies
      SfxType.gameOver => const ['gameover.mp3'],
      //TODO: add when bonus screen appears
      SfxType.bonusScreen1 => const ['bonus_screen1.mp3'],
      SfxType.bonusScreen2 => const ['bonus_screen2.mp3'],
      //TODO: add when enemy appears or attacks
      SfxType.enemyRoar1 => const ['enemy_roar1.mp3'],
      SfxType.enemyRoar2 => const ['enemy_roar2.mp3'],
      SfxType.wolfHowl => const ['wolf_howl.mp3'],
      SfxType.monsterLaugh => const ['monster_laugh.mp3'],
      SfxType.monsterHeh => const ['monster_heh.mp3'],
      //TODO: Add when player turn
      SfxType.cuteTroll1 => const ['cute_troll1.mp3'],
      SfxType.cuteTroll2 => const ['cute_troll2.mp3'],
      SfxType.cuteTroll3 => const ['cute_troll3.mp3'],
      SfxType.cuteTroll4 => const ['cute_troll4.mp3'],
    };

double soundTypeToVolume(SfxType type) {
  switch (type) {
    case SfxType.buttonTap:
    case SfxType.addPlayerPop:
    case SfxType.deletePlayerPop:
    case SfxType.punch:
    case SfxType.scratch:
    case SfxType.gameOver:
    case SfxType.bonusScreen1:
    case SfxType.bonusScreen2:
    case SfxType.enemyRoar1:
    case SfxType.enemyRoar2:
    case SfxType.wolfHowl:
    case SfxType.cuteTroll1:
    case SfxType.cuteTroll2:
    case SfxType.cuteTroll3:
    case SfxType.cuteTroll4:
    case SfxType.monsterLaugh:
    case SfxType.monsterHeh:
      return 1.0;
    case SfxType.drawing:
      return 3.0;
  }
}

List<SfxType> enemyRoars = [
  SfxType.enemyRoar1,
  SfxType.enemyRoar2,
];

List<SfxType> playerShouts = [
  SfxType.cuteTroll1,
  SfxType.cuteTroll2,
  SfxType.cuteTroll3,
  SfxType.cuteTroll4,
];

enum SfxType {
  buttonTap,
  addPlayerPop,
  deletePlayerPop,
  drawing,
  punch,
  scratch,
  gameOver,
  bonusScreen1,
  bonusScreen2,
  enemyRoar1,
  enemyRoar2,
  wolfHowl,
  cuteTroll1,
  cuteTroll2,
  cuteTroll3,
  cuteTroll4,
  monsterLaugh,
  monsterHeh,
}
