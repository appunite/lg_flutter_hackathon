import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:lg_flutter_hackathon/battle/presentation/battle_screen.dart';

import 'main_menu/main_menu_screen.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainMenuScreen(key: Key('main_menu')),
    ),
    GoRoute(
      path: '/battle',
      builder: (context, state) => const BattleScreen(key: Key('battle_screen')),
    ),
  ],
);
