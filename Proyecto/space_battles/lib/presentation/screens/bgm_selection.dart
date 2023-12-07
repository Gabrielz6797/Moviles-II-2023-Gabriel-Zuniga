import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:space_battles/models/bgm.dart';
import 'package:space_battles/models/player_data.dart';

class BGMSelection extends StatefulWidget {
  const BGMSelection({super.key});

  @override
  State<BGMSelection> createState() => _BGMSelectionState();
}

class _BGMSelectionState extends State<BGMSelection> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select',
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
                itemCount: BGM.bgms.length,
                initialPage: PlayerData.bgm.bgmID,
                slideBuilder: (index) {
                  final bgm = BGM.bgms.elementAt(index);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        bgm.name.substring(0, bgm.name.length - 4),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      PlayerData.bgm.bgmID != index
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 16,
                              child: ElevatedButton(
                                onPressed: () {
                                  PlayerData.bgm.bgmID = index;
                                  PlayerData.bgm.name = BGM.bgms[index].name;
                                  PlayerData.audioPlayerComponent.stopBGM();
                                  PlayerData.audioPlayerComponent
                                      .playBGM(PlayerData.bgm.name);
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
