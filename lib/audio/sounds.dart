List<String> soundTypeToFilename(SfxType type) => switch (type) {
      SfxType.buttonTap => const ['sh1.mp3'],
      SfxType.addPlayerPop => const ['add_player_pop.mp3'],
      SfxType.deletePlayerPop => const ['delete_player_pop.mp3'],
      SfxType.drawing => const ['drawing.mp3'],
    };

double soundTypeToVolume(SfxType type) {
  switch (type) {
    case SfxType.buttonTap:
    case SfxType.addPlayerPop:
    case SfxType.deletePlayerPop:
      return 1.0;
    case SfxType.drawing:
      return 5.0;
  }
}

enum SfxType { buttonTap, addPlayerPop, deletePlayerPop, drawing }
