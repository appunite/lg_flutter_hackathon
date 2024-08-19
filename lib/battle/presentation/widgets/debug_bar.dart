import 'package:flutter/material.dart';

class DebugBar extends StatelessWidget {
  const DebugBar({
    super.key,
    required this.onDrawRune,
    required this.onGameEnd,
  });

  final VoidCallback onDrawRune;
  final VoidCallback onGameEnd;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.black.withOpacity(0.8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: onDrawRune,
              child: const Text('Draw Rune'),
            ),
            ElevatedButton(
              onPressed: onGameEnd,
              child: const Text('End Game'),
            ),
          ],
        ),
      ),
    );
  }
}
