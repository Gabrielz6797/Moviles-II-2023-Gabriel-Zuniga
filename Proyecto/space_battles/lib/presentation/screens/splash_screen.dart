import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:space_battles/models/player_data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      PlayerData.audioPlayerComponent.playBGM(PlayerData.bgm.name);
      context.go('/main-menu');
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SPACE BATTLES',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(blurRadius: 40, color: colors.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
