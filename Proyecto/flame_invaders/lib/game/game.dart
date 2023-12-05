import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame_invaders/game/player.dart';
import 'package:flutter/material.dart';

class FlameInvadersGame extends FlameGame with PanDetector {
  late Player player;
  Offset? _pointerStartPosition;
  Offset? _pointerCurrentPosition;
  final double _joyStickRadius = 60;
  final double _joyStickCenterRadius = 20;
  final double _deadZoneRadius = 10;
  final double _movementSpeed1MaxRadius = 25;
  final double _movementSpeed2MaxRadius = 40;
  final double _movementSpeed3MaxRadius = 55;
  final double _movementSpeed1 = 50;
  final double _movementSpeed2 = 100;
  final double _movementSpeed3 = 200;
  final double _movementSpeed4 = 300;

  @override
  FutureOr<void> onLoad() async {
    await images.load('simpleSpace_tilesheet@2.png');

    final spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: images.fromCache('simpleSpace_tilesheet@2.png'),
      columns: 8,
      rows: 6,
    );

    player = Player(
      sprite: spriteSheet.getSpriteById(17),
      size: Vector2(64, 64),
      position: Vector2(canvasSize[0] / 2, canvasSize[1] - 100),
    );

    player.anchor = Anchor.bottomCenter;

    add(player);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (_pointerStartPosition != null) {
      canvas.drawCircle(
        _pointerStartPosition!,
        _joyStickRadius,
        Paint()..color = Colors.white24,
      );
    }

    if (_pointerCurrentPosition != null) {
      var delta = _pointerCurrentPosition! - _pointerStartPosition!;

      if (delta.distance > _joyStickRadius) {
        delta = _pointerStartPosition! +
            (Vector2(delta.dx, delta.dy).normalized() * _joyStickRadius)
                .toOffset();
      } else {
        delta = _pointerCurrentPosition!;
      }

      canvas.drawCircle(
        delta,
        _joyStickCenterRadius,
        Paint()..color = Colors.white,
      );
    }
  }

  @override
  void onPanStart(DragStartInfo info) {
    _pointerStartPosition = info.raw.globalPosition;
    _pointerCurrentPosition = info.raw.globalPosition;
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    _pointerCurrentPosition = info.raw.globalPosition;
    var delta = _pointerCurrentPosition! - _pointerStartPosition!;

    // Upddate direction
    if (delta.distance <= _deadZoneRadius) {
      player.setMoveDirection(Vector2.zero());
    } else {
      player.setMoveDirection(Vector2(delta.dx, delta.dy));
    }

    // Update speed
    if (delta.distance <= _deadZoneRadius) {
      player.setMoveSpeed(0);
    } else if (delta.distance > _deadZoneRadius &&
        delta.distance <= _movementSpeed1MaxRadius) {
      player.setMoveSpeed(_movementSpeed1);
    } else if (delta.distance > _movementSpeed1MaxRadius &&
        delta.distance <= _movementSpeed2MaxRadius) {
      player.setMoveSpeed(_movementSpeed2);
    } else if (delta.distance > _movementSpeed2MaxRadius &&
        delta.distance <= _movementSpeed3MaxRadius) {
      player.setMoveSpeed(_movementSpeed3);
    } else if (delta.distance > _movementSpeed3MaxRadius) {
      player.setMoveSpeed(_movementSpeed4);
    }
  }

  @override
  void onPanEnd(DragEndInfo info) {
    _pointerStartPosition = null;
    _pointerCurrentPosition = null;
    player.setMoveDirection(Vector2.zero());
    player.setMoveSpeed(0);
  }

  @override
  void onPanCancel() {
    _pointerStartPosition = null;
    _pointerCurrentPosition = null;
    player.setMoveDirection(Vector2.zero());
    player.setMoveSpeed(0);
  }
}
