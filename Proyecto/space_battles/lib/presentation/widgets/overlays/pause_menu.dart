import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:space_battles/game/game.dart';
import 'package:space_battles/presentation/widgets.dart';

class PauseMenu extends StatelessWidget {
  static const String id = 'PauseMenu';
  final SpaceBattlesGame gameRef;

  const PauseMenu({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Text(
              'PAUSED',
              style: TextStyle(fontSize: 40, shadows: [
                Shadow(blurRadius: 40, color: colors.primary),
              ]),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.6,
            height: MediaQuery.of(context).size.height / 16,
            child: ElevatedButton(
              onPressed: () {
                gameRef.resumeEngine();
                gameRef.overlays.remove(PauseMenu.id);
                gameRef.overlays.add(PauseButton.id);
              },
              child: const Text(
                'Resume',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.6,
            height: MediaQuery.of(context).size.height / 16,
            child: ElevatedButton(
              onPressed: () {
                context.pop();
                context.push('/play-game');
              },
              child: const Text(
                'Restart',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.6,
            height: MediaQuery.of(context).size.height / 16,
            child: ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text(
                'Exit',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
