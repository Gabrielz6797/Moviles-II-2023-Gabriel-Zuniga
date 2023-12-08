import 'package:flutter/material.dart';
import 'package:space_battles/game/game.dart';
import 'package:space_battles/presentation/widgets.dart';

/// [PauseButton] Shows a pause button in the game
class PauseButton extends StatelessWidget {
  static const String id = 'PauseButton';
  final SpaceBattlesGame gameRef;
  const PauseButton({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () {
          gameRef.pauseEngine();
          gameRef.overlays.add(PauseMenu.id);
          gameRef.overlays.remove(PauseButton.id);
        },
        child: const Icon(
          Icons.pause_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
