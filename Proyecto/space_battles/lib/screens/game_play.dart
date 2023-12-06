import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:space_battles/game/game.dart';
import 'package:space_battles/widgets/overlays/pause_button.dart';
import 'package:space_battles/widgets/overlays/pause_menu.dart';

class GamePlay extends StatelessWidget {
  const GamePlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: GameWidget(
          game: SpaceBattlesGame(),
          initialActiveOverlays: const [PauseButton.id],
          overlayBuilderMap: {
            PauseButton.id: (BuildContext context, SpaceBattlesGame gameRef) =>
                PauseButton(
                  gameRef: gameRef,
                ),
            PauseMenu.id: (BuildContext context, SpaceBattlesGame gameRef) =>
                PauseMenu(
                  gameRef: gameRef,
                ),
          },
        ),
      ),
    );
  }
}
