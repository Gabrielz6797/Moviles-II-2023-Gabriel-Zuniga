import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// [OptionsScreen] Allows the user to access options
class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Options',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(blurRadius: 40, color: colors.primary),
                  ],
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
                    context.go('/spaceship-selection');
                  },
                  child: const Text(
                    'Spaceship',
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
                    context.go('/bgm-selection');
                  },
                  child: const Text(
                    'Music',
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
