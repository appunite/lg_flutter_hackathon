import 'package:flutter/material.dart';
import 'package:lg_flutter_hackathon/audio/audio_controller.dart';
import 'package:lg_flutter_hackathon/constants/strings.dart';
import 'package:provider/provider.dart';

class ConfirmationPopUp extends StatelessWidget {
  const ConfirmationPopUp({super.key, required this.title, this.alertMessage});

  final String title;
  final String? alertMessage;

  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioController>();

    Widget yesButton = TextButton(
      child: const Text(Strings.yes),
      onPressed: () {
        audioController.setSong(audioController.themeSong);
        Navigator.popAndPushNamed(context, '/');
      },
    );
    Widget cancelButton = TextButton(
      child: const Text(
        Strings.cancel,
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    return AlertDialog(
      title: Text(title),
      content: alertMessage != null ? Text(alertMessage!) : null,
      actions: [yesButton, cancelButton],
    );
  }
}
