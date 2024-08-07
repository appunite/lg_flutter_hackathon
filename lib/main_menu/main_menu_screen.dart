import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lg_flutter_hackathon/buttons/primary_button.dart';
import 'package:lg_flutter_hackathon/components/confirmation_pop_up.dart';
import 'package:lg_flutter_hackathon/constants/strings.dart';
import 'package:provider/provider.dart';
import '../settings/settings.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              soundSettings(settingsController),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/battle');
                    },
                    child: const Text(Strings.twoPlayers),
                  ),
                  const Gap(10),
                  PrimaryButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/battle');
                    },
                    child: const Text(Strings.threePlayers),
                  ),
                  const Gap(10),
                  PrimaryButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/battle');
                    },
                    child: const Text(Strings.fourPlayers),
                  ),
                  const Gap(10),
                  PrimaryButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const ConfirmationPopUp(title: Strings.exitConfirmation);
                        },
                      );
                    },
                    child: const Text('Quit'),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
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
