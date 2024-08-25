import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/level_enum.dart';
import 'package:lg_flutter_hackathon/battle/domain/entities/players_entity.dart';
import 'package:lg_flutter_hackathon/battle/presentation/battle_screen.dart';
import 'package:lg_flutter_hackathon/bonuses/bonuses_screen.dart';
import 'package:lg_flutter_hackathon/constants/image_assets.dart';
import 'package:lg_flutter_hackathon/dependencies.dart';
import 'package:lg_flutter_hackathon/main_menu/main_menu_screen.dart';
import 'package:lg_flutter_hackathon/splash/presentation/pages/splash_screen.dart';
import 'package:lg_flutter_hackathon/story/domain/ending_story_enum.dart';
import 'package:lg_flutter_hackathon/story/domain/opening_story_enum.dart';
import 'package:lg_flutter_hackathon/story/presentation/ending_story_screen.dart';
import 'package:lg_flutter_hackathon/story/presentation/opening_story_screen.dart';
import 'package:lg_flutter_hackathon/utils/window_manager_utils.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'app_lifecycle/app_lifecycle.dart';
import 'audio/audio_controller.dart';
import 'settings/settings.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      _precacheSvg();

      if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
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

          windowManager.addListener(WindowManagerListener());
        });
      }

      setupDependencies();

      runApp(const App());
    },
    (e, st) {
      debugPrintStack(stackTrace: st, label: e.toString());
    },
  );
}

void _precacheSvg() {
  for (final asset in assetsList) {
    final loader = SvgAssetLoader(asset);
    svg.cache.putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    Bloc.observer = AppBlocObserver();

    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          ProxyProvider<AppLifecycleStateNotifier, SettingsController>(
            create: (context) => SettingsController(),
            update: (context, lifecycleNotifier, settings) {
              sl.get<AudioController>().attachDependencies(lifecycleNotifier, settings!);
              return settings;
            },
            dispose: (context, value) => sl.get<AudioController>().dispose(),
            lazy: false,
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp(
            title: 'Trolls in a Trench Coat',
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
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
              '/': (context) => const SplashScreen(),
              '/main-menu': (context) => const MainMenuScreen(),
              '/battle': (context) => const BattleScreen(
                    level: LevelEnum.first,
                    players: PlayersEntity(healthPoints: 100, numberOfPlayers: 4, damage: 1000),
                  ),
              '/bonuses': (context) => const BonusesScreen(
                    level: LevelEnum.first,
                    players: PlayersEntity(healthPoints: 100, numberOfPlayers: 4, damage: 10),
                  ),
              '/opening-story': (context) => OpeningStoryScreen(
                    step: OpeningStoryStep.values.first,
                  ),
              '/ending-story': (context) => EndingStoryScreen(
                    step: EndingStoryStep.values.first,
                  ),
            },
          );
        }),
      ),
    );
  }
}

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    debugPrint('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    debugPrint('onClose -- ${bloc.runtimeType}');
  }
}
