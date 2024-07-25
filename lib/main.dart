import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('LG hackathon'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                side: const BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              child: const Text('2 players'),
            ),
            const SizedBox(height: 10.0),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                side: const BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              child: const Text('3 players'),
            ),
            const SizedBox(height: 10.0),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                side: const BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              child: const Text('4 players'),
            ),
            const SizedBox(height: 100.0),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                side: const BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
              ),
              child: const Text('Quit'),
            ),
          ],
        ),
      ),
    ));
  }
}
