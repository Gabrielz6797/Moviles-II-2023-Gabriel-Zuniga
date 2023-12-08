import 'package:space_battles/presentation/blocs.dart';
import 'package:space_battles/presentation/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ScoresCubit>().getScores();
  }

  @override
  Widget build(BuildContext context) {
    final scores = context.watch<ScoresCubit>().state.scores;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                'Leaderboard',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(blurRadius: 40, color: colors.primary),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: (scores.isNotEmpty)
                    ? ListView.builder(
                        itemCount: scores.length,
                        itemBuilder: (context, index) {
                          final post = scores[index];
                          return Column(
                            children: [
                              CustomTextBox(
                                fieldTitle:
                                    "#${index + 1}: ${post['username']}",
                                fieldData: "Score: ${post['score'].toString()}",
                                editable: false,
                                image: false,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          );
                        },
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height / 16,
                          child: const Text(
                            'There are no scores yet',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
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
                    context.go('/main-menu');
                  },
                  child: const Text(
                    'Home',
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
