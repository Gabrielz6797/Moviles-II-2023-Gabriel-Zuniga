import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:space_battles/game/game.dart';
import 'package:space_battles/presentation/blocs.dart';

class GameOverMenu extends StatelessWidget {
  static const String id = 'GameOverMenu';
  final SpaceBattlesGame gameRef;
  const GameOverMenu({super.key, required this.gameRef});

  void saveScore(BuildContext context, AuthCubit authCubit,
      ScoresCubit scoresCubit) async {
    int playerHighScore = authCubit.state.score;
    if (authCubit.state.email != '') {
      scoresCubit.addScore(
        authCubit.state.email,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          authCubit.state.email != ''
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Text(
                    'GAME OVER',
                    style: TextStyle(fontSize: 40, shadows: [
                      Shadow(blurRadius: 40, color: colors.primary),
                    ]),
                  ),
                )
              : Text(
                  'GAME OVER',
                  style: TextStyle(fontSize: 40, shadows: [
                    Shadow(blurRadius: 40, color: colors.primary),
                  ]),
                ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 16,
            child: authCubit.state.email != ''
                ? ElevatedButton(
                    onPressed: () {
                      saveScore(context, authCubit, scoresCubit);
                    },
                    child: const Text(
                      'Save & exit',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : const Text(
                    'Login to save your score!',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
          ),
          authCubit.state.email != ''
              ? const SizedBox(
                  height: 25,
                )
              : const SizedBox(
                  height: 15,
                ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 16,
            child: ElevatedButton(
              onPressed: () {
                context.pop();
                context.push('/game-play');
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
            width: MediaQuery.of(context).size.width / 2,
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
