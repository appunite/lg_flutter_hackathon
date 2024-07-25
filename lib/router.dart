import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import 'main_menu/main_menu_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainMenuScreen(key: Key('main menu')),
    ),
  ],
);
