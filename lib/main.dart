import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lg_flutter_hackathon/battle/presentation/battle_screen.dart';

import 'package:lg_flutter_hackathon/constants/colors.dart';
import 'package:lg_flutter_hackathon/dependencies.dart';
import 'package:lg_flutter_hackathon/main_menu/main_menu_screen.dart';

import 'package:provider/provider.dart';

import 'app_lifecycle/app_lifecycle.dart';
import 'audio/audio_controller.dart';
import 'settings/settings.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      setupDependencies();

      runApp(const MyApp());
    },
    (e, st) {
      debugPrintStack(stackTrace: st, label: e.toString());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          Provider(create: (context) => SettingsController()),
          ProxyProvider2<AppLifecycleStateNotifier, SettingsController, AudioController>(
            create: (context) => AudioController(),
            update: (context, lifecycleNotifier, settings, audio) {
              audio!.attachDependencies(lifecycleNotifier, settings);
              return audio;
            },
            dispose: (context, audio) => audio.dispose(),
            lazy: false,
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp(
            title: 'LG hackathon',
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
              scaffoldBackgroundColor: AppColors.background,
              textTheme: const TextTheme(
                headlineLarge: TextStyle(color: AppColors.primary),
              ),
            ).copyWith(
              filledButtonTheme: FilledButtonThemeData(
                style: FilledButton.styleFrom(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => const MainMenuScreen(),
              '/battle': (context) => const BattleScreen(),
            },
          );
        }),
      ),
    );
  }
}
