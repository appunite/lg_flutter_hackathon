import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:lg_flutter_hackathon/audio/songs.dart';
import 'package:lg_flutter_hackathon/audio/sounds.dart';
import 'package:lg_flutter_hackathon/logger.dart';

import '../app_lifecycle/app_lifecycle.dart';
import '../settings/settings.dart';

class AudioController with ReporterMixin {
  final AudioPlayer _musicPlayer;

  final List<AudioPlayer> _sfxPlayers;

  int _currentSfxPlayer = 0;

  final Queue<Song> _playlist;

  final Random _random = Random();

  SettingsController? _settings;

  ValueNotifier<AppLifecycleState>? _lifecycleNotifier;

  /// Use [polyphony] to configure the number of sound effects (SFX) that can
  /// play at the same time. A [polyphony] of `1` will always only play one
  /// sound (a new sound will stop the previous one).
  AudioController({int polyphony = 2})
      : assert(polyphony >= 1),
        _musicPlayer = AudioPlayer(playerId: 'musicPlayer'),
        _sfxPlayers =
            Iterable.generate(polyphony, (i) => AudioPlayer(playerId: 'sfxPlayer#$i')).toList(growable: false),
        _playlist = Queue.of(List<Song>.of(songs)..shuffle()) {
    _musicPlayer.onPlayerComplete.listen(_handleSongFinished);
    unawaited(_preloadSfx());
  }

  void attachDependencies(AppLifecycleStateNotifier lifecycleNotifier, SettingsController settingsController) {
    _attachLifecycleNotifier(lifecycleNotifier);
    _attachSettings(settingsController);
  }

  void dispose() {
    _lifecycleNotifier?.removeListener(_handleAppLifecycle);
    _stopAllSound();
    _musicPlayer.dispose();
    for (final player in _sfxPlayers) {
      player.dispose();
    }
  }

  void playSfx(SfxType type) {
    final soundsOn = _settings?.soundsOn.value ?? false;
    if (!soundsOn) {
      return;
    }

    final options = soundTypeToFilename(type);
    final filename = options[_random.nextInt(options.length)];

    final currentPlayer = _sfxPlayers[_currentSfxPlayer];
    currentPlayer.play(AssetSource('sfx/$filename'), volume: soundTypeToVolume(type));
    _currentSfxPlayer = (_currentSfxPlayer + 1) % _sfxPlayers.length;
  }

  void _attachLifecycleNotifier(AppLifecycleStateNotifier lifecycleNotifier) {
    _lifecycleNotifier?.removeListener(_handleAppLifecycle);

    lifecycleNotifier.addListener(_handleAppLifecycle);
    _lifecycleNotifier = lifecycleNotifier;
  }

  void _attachSettings(SettingsController settingsController) {
    if (_settings == settingsController) {
      return;
    }
    final oldSettings = _settings;
    if (oldSettings != null) {
      oldSettings.musicOn.removeListener(_musicOnHandler);
      oldSettings.soundsOn.removeListener(_soundsOnHandler);
    }

    _settings = settingsController;

    settingsController.musicOn.addListener(_musicOnHandler);
    settingsController.soundsOn.addListener(_soundsOnHandler);

    if (settingsController.musicOn.value) {
      if (!kIsWeb) {
        _playCurrentSongInPlaylist();
      }
    }
  }

  void _handleAppLifecycle() {
    switch (_lifecycleNotifier!.value) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        _stopAllSound();
      case AppLifecycleState.resumed:
        if (_settings!.musicOn.value) {
          _startOrResumeMusic();
        }
      case AppLifecycleState.inactive:
        break;
    }
  }

  void _handleSongFinished(void _) {
    _playlist.addLast(_playlist.removeFirst());
    _playCurrentSongInPlaylist();
  }

  void _musicOnHandler() {
    if (_settings!.musicOn.value) {
      _startOrResumeMusic();
    } else {
      _musicPlayer.pause();
    }
  }

  Future<void> _playCurrentSongInPlaylist() async {
    try {
      await _musicPlayer.play(AssetSource('/music/${_playlist.first.filename}'), volume: 0.5);
    } catch (e, st) {
      logError(e, st, message: 'Could not play song ${_playlist.first}');
    }
  }

  Future<void> _preloadSfx() async {
    await AudioCache.instance.loadAll(SfxType.values.expand(soundTypeToFilename).map((path) => 'sfx/$path').toList());
  }

  void _soundsOnHandler() {
    for (final player in _sfxPlayers) {
      if (player.state == PlayerState.playing) {
        player.stop();
      }
    }
  }

  void _startOrResumeMusic() async {
    if (_musicPlayer.source == null) {
      await _playCurrentSongInPlaylist();
      return;
    }

    try {
      _musicPlayer.resume();
    } catch (e, st) {
      logError(e, st, message: 'Error resuming music');
      _playCurrentSongInPlaylist();
    }
  }

  void _stopAllSound() {
    _musicPlayer.pause();
    for (final player in _sfxPlayers) {
      player.stop();
    }
  }
}
