import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:space_battles/presentation/blocs.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();
    final email = context.watch<AuthCubit>().state.email;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Text(
                'SPACE BATTLES',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(blurRadius: 40, color: colors.primary),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 16,
              child: ElevatedButton(
                onPressed: () {
                  context.push('/game-play');
                },
                child: const Text(
                  'Play',
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
                onPressed: () {},
                child: const Text(
                  'Options',
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
                  context.go('/profile');
                },
                child: const Text(
                  'Profile',
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
              child: email == ''
                  ? ElevatedButton(
                      onPressed: () {
                        context.go('/Login');
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        authCubit
                            .signOutUser()
                            .then((value) => context.go('/main-menu'));
                      },
                      child: const Text(
                        'Logout',
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
    );
  }
}
