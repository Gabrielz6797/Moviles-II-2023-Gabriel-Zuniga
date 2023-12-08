import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:space_battles/models/player_data.dart';
import 'package:space_battles/models/spaceship.dart';

/// [SpaceshipSelection] Allows the player to choose a spaceship
class SpaceshipSelection extends StatefulWidget {
  const SpaceshipSelection({super.key});

  @override
  State<SpaceshipSelection> createState() => _SpaceshipSelectionState();
}

class _SpaceshipSelectionState extends State<SpaceshipSelection> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select spaceship',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(blurRadius: 40, color: colors.primary),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: CarouselSlider.builder(
                itemCount: Spaceship.spaceships.length,
                initialPage: PlayerData.spaceship.spriteID,
                slideBuilder: (index) {
                  final spaceship = Spaceship.spaceships.elementAt(index);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(spaceship.assetPath),
                      const SizedBox(
                        height: 25,
                      ),
                      PlayerData.spaceship.spriteID != index
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 16,
                              child: ElevatedButton(
                                onPressed: () {
                                  PlayerData.spaceship.spriteID = index;
                                  PlayerData.spaceship.assetPath =
                                      Spaceship.spaceships[index].assetPath;
                                  setState(() {});
                                },
                                child: const Text(
                                  'Select',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            )
                          : SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 16,
                              child: const ElevatedButton(
                                onPressed: null,
                                child: Text(
                                  'Selected',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                    ],
                  );
                },
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
                  context.go('/options');
                },
                child: const Text(
                  'Back',
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
