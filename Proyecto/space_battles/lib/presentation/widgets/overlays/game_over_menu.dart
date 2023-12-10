import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:space_battles/game/game.dart';
import 'package:space_battles/presentation/blocs.dart';

/// [GameOverMenu] Shows a gameover screen when the player dies
class GameOverMenu extends StatelessWidget {
  static const String id = 'GameOverMenu';
  final SpaceBattlesGame gameRef;
  const GameOverMenu({super.key, required this.gameRef});

  void saveScore(BuildContext context, AuthCubit authCubit,
      ScoresCubit scoresCubit) async {
    int playerHighScore = authCubit.state.score;
    if (authCubit.state.email != '') {
      scoresCubit.addScore(
        authCubit.state.username,
        gameRef.player.score,
      );

      if (playerHighScore < gameRef.player.score) {
        authCubit.updateUserData(
          authCubit.state.email,
          'score',
          gameRef.player.score,
        );
      }
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();
    final scoresCubit = context.watch<ScoresCubit>();
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: SingleChildScrollView(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'GAME OVER',
                    style: TextStyle(
                      fontSize: 40,
                      shadows: [
                        Shadow(blurRadius: 40, color: colors.primary),
                      ],
                    ),
                  ),
                  Text(
                    'Score: ${gameRef.player.score}',
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              authCubit.state.email != ''
                  ? const SizedBox(
                      height: 20,
                    )
                  : const SizedBox(
                      height: 5,
                    ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.6,
                height: MediaQuery.of(context).size.height / 16,
                child: authCubit.state.email != ''
                    ? ElevatedButton(
                        onPressed: () {
                          saveScore(context, authCubit, scoresCubit);
                        },
                        child: const Text(
                          'Save & exit',
                          style: TextStyle(fontSize: 24),
                        ),
                      )
                    : const Text(
                        'Login to save your score!',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
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
                    context.pushReplacement('/play-game');
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
        ),
      ),
    );
  }
}
