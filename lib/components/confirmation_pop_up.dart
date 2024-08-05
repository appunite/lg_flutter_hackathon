import 'package:flutter/material.dart';
import 'package:lg_flutter_hackathon/constants/strings.dart';

class ConfirmationPopUp extends StatelessWidget {
  const ConfirmationPopUp({super.key, required this.title, this.alertMessage});

  final String title;
  final String? alertMessage;

  @override
  Widget build(BuildContext context) {
    Widget yesButton = TextButton(
      child: const Text(Strings.yes),
      onPressed: () {
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
