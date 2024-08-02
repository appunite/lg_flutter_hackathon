import 'package:flutter/material.dart';
import 'package:lg_flutter_hackathon/constants/strings.dart';
import 'package:lg_flutter_hackathon/router.dart';

class ConfirmationPopUp extends StatelessWidget {
  const ConfirmationPopUp({super.key, required this.title, this.alertMessage});

  final String title;
  final String? alertMessage;

  @override
  Widget build(BuildContext context) {
    Widget yesButton = TextButton(
      child: const Text(Strings.yes),
      onPressed: () {
        router.pop();
        router.go('/');
      },
    );
    Widget cancelButton = TextButton(
      child: const Text(
        Strings.cancel,
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        router.pop();
      },
    );
    return AlertDialog(
      title: Text(title),
      content: alertMessage != null ? Text(alertMessage!) : null,
      actions: [yesButton, cancelButton],
    );
  }
}
