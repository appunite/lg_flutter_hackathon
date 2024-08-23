import 'package:flutter/foundation.dart';
import 'package:lg_flutter_hackathon/settings/settings_prefs/settings_prefs.dart';
import 'package:lg_flutter_hackathon/settings/settings_prefs/local_storage_settings_prefs.dart';

class SettingsController {
  final SettingsPrefs _store;

  ValueNotifier<bool> soundsOn = ValueNotifier(false);

  ValueNotifier<bool> musicOn = ValueNotifier(false);

  ValueNotifier<bool> tutorial = ValueNotifier(true);

  SettingsController({SettingsPrefs? store}) : _store = store ?? LocalStorageSettingsPrefs() {
    _loadStateFromPrefs();
  }

  void toggleMusicOn() {
    musicOn.value = !musicOn.value;
    _store.saveMusicOn(musicOn.value);
  }

  void toggleSoundsOn() {
    soundsOn.value = !soundsOn.value;
    _store.saveSoundsOn(soundsOn.value);
  }

  void showTutorial(bool show) {
    tutorial.value = show;
    _store.setTutorial(tutorial.value);
  }

  Future<void> _loadStateFromPrefs() async {
    await Future.wait([
      _store.getMusicOn(defaultValue: true).then((value) {
        if (kIsWeb) {
          return musicOn.value = false;
        }
        return musicOn.value = value;
      }),
      _store.getSoundsOn(defaultValue: true).then((value) => soundsOn.value = value),
    ]);
  }
}
