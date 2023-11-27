import 'package:go_router/go_router.dart';
import 'package:api_consumption/presentation/screens.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
