import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'package:lg_flutter_hackathon/battle/presentation/battle_screen.dart';
import 'package:lg_flutter_hackathon/constants/colors.dart';
import 'package:lg_flutter_hackathon/main_menu/main_menu_screen.dart';

import 'app_lifecycle/app_lifecycle.dart';
import 'audio/audio_controller.dart';
import 'settings/settings.dart';

import 'package:logging/logging.dart';

void main() async {
  initializeLogger();

  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1280, 720),
    minimumSize: Size(1280, 720),
    maximumSize: Size(3840, 2160),
    center: true,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();

    windowManager.addListener(MyWindowListener());
  });

  await runZonedGuarded(
    () async {
      runApp(const MyApp());
    },
    (e, st) {
      Logger.root.severe('Unhandled exception in runZonedGuarded', e, st);
    },
  );
}

void initializeLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.time} [${record.level.name}] ${record.loggerName}: ${record.message}');
    if (record.error != null) {
      debugPrint('Error: ${record.error}');
    }
    if (record.stackTrace != null) {
      debugPrint('StackTrace: ${record.stackTrace}');
    }
  });
}

class MyWindowListener extends WindowListener {
  @override
  void onWindowResize() {
    _maintainAspectRatio();
  }

  void _maintainAspectRatio() async {
    final currentSize = await windowManager.getSize();
    final double aspectRatio = 16 / 9;

    double newWidth = currentSize.width;
    double newHeight = currentSize.height;

    if ((currentSize.width / currentSize.height).toStringAsFixed(2) != aspectRatio.toStringAsFixed(2)) {
      if (currentSize.width / aspectRatio <= currentSize.height) {
        newHeight = currentSize.width / aspectRatio;
      } else {
        newWidth = currentSize.height * aspectRatio;
      }

      windowManager.setSize(Size(newWidth, newHeight));
    }
  }
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
