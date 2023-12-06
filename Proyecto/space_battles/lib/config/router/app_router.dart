import 'package:space_battles/screens/main_menu.dart';
import 'package:space_battles/screens/game_play.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainMenu(),
    ),
    GoRoute(
      path: '/game-play',
      builder: (context, state) => const GamePlay(),
    ),
  ],
);
