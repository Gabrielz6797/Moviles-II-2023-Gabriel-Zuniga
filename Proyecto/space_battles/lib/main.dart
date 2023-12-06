import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:space_battles/game/game.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  runApp(
    GameWidget(
      game: SpaceBattlesGame(),
    ),
  );
}
