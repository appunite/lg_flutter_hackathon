import 'package:flutter/material.dart';

class OverlayWidget extends StatelessWidget {
  const OverlayWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.7),
    );
  }
}