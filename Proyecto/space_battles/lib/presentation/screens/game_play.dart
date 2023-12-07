import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:space_battles/game/game.dart';
import 'package:space_battles/presentation/widgets.dart';

class GamePlay extends StatefulWidget {
  const GamePlay({super.key});

  @override
  State<GamePlay> createState() => _GamePlayState();
}

class _GamePlayState extends State<GamePlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: GameWidget(
          game: SpaceBattlesGame(shipID: 14),
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
            GameOverMenu.id: (BuildContext context, SpaceBattlesGame gameRef) =>
                GameOverMenu(
                  gameRef: gameRef,
                ),
          },
        ),
      ),
    );
  }
}
