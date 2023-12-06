import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:space_battles/config/router/app_router.dart';
import 'package:space_battles/config/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getAppTheme(),
      routerConfig: appRouter,
    );
  }
}
