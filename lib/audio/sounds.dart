List<String> soundTypeToFilename(SfxType type) => switch (type) {
      SfxType.dsht => const ['dsht1.mp3'],
      SfxType.buttonTap => const ['sh1.mp3'],
    };

double soundTypeToVolume(SfxType type) {
  switch (type) {
    case SfxType.dsht:
      return 0.4;
    case SfxType.buttonTap:
      return 1.0;
  }
}

enum SfxType {
  dsht,
  buttonTap,
}
