import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lg_flutter_hackathon/buttons/primary_button.dart';
import 'package:provider/provider.dart';
import '../settings/settings.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            soundSettings(settingsController),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryButton(
                  onPressed: () {},
                  child: const Text('2 players'),
                ),
                const Gap(10),
                PrimaryButton(
                  onPressed: () {},
                  child: const Text('3 players'),
                ),
                const Gap(10),
                PrimaryButton(
                  onPressed: () {},
                  child: const Text('4 players'),
                ),
                const Gap(10),
                PrimaryButton(
                  onPressed: () {},
                  child: const Text('Quit'),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget soundSettings(SettingsController settingsController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: settingsController.musicOn,
          builder: (context, musicOn, child) {
            return IconButton(
              onPressed: settingsController.toggleMusicOn,
              icon: Icon(musicOn ? Icons.volume_up : Icons.volume_off),
            );
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: settingsController.soundsOn,
          builder: (context, soundsOn, child) {
            return IconButton(
              onPressed: settingsController.toggleSoundsOn,
              icon: Icon(soundsOn ? Icons.music_note : Icons.music_off),
            );
          },
        ),
      ],
    );
  }
}
