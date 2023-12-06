import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:space_battles/game/enemy.dart';
import 'package:space_battles/game/enemy_bullet.dart';
import 'package:space_battles/game/player.dart';
import 'package:space_battles/game/player_bullet.dart';
import 'package:flutter/material.dart';

class SpaceBattlesGame extends FlameGame
    with PanDetector, TapDetector, HasCollisionDetection {
  late SpriteSheet _spriteSheet;
  late Player player;
  late Enemy enemy;
  late Timer _enemyActionTimer;
  late Timer _gameOverTimer;
  late TextComponent _playerScore;
  late TextComponent _playerHealth;
  late TextComponent _enemyHealth;
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
  int _enemySpriteID = Random().nextInt(24);
  bool _enemySpawnPositionNegative = Random().nextBool();
  bool _playerDestroyed = false;
  bool _enemyDestroyed = false;

  @override
  FutureOr<void> onLoad() async {
    await images.load('simpleSpace_tilesheet@2.png');

    _spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: images.fromCache('simpleSpace_tilesheet@2.png'),
      columns: 8,
      rows: 6,
    );

    player = Player(
      sprite: _spriteSheet.getSpriteById(17),
      size: Vector2(64, 64),
      position: Vector2(canvasSize[0] / 2, canvasSize[1] - 100),
    );
    player.setMaxPosition(canvasSize);
    player.anchor = Anchor.bottomCenter;
    add(player);

    enemy = Enemy(
        sprite: _spriteSheet.getSpriteById(_enemySpriteID),
        size: Vector2(64, 64),
        position: _enemySpawnPositionNegative
            ? Vector2(canvasSize[0] / 2, 100) + Vector2.random() * -200
            : Vector2(canvasSize[0] / 2, 100) + Vector2.random() * 200);
    enemy.setMaxPosition(canvasSize);
    enemy.anchor = Anchor.topCenter;
    add(enemy);

    _enemyActionTimer = Timer(0.5, onTick: _enemyAction, repeat: true);
    _enemyActionTimer.start();

    _gameOverTimer = Timer(1, onTick: _showGameOverMessage);

    _playerScore = TextComponent(
      text: 'Score: 0',
      position: Vector2(10, size.y - 10),
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white60,
        ),
      ),
    );
    _playerScore.anchor = Anchor.bottomLeft;
    add(_playerScore);

    _playerHealth = TextComponent(
      text: 'Health: 100%',
      position: Vector2(size.x - 10, size.y - 10),
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
    _playerHealth.anchor = Anchor.bottomRight;
    add(_playerHealth);

    _enemyHealth = TextComponent(
      text: 'Health: 100%',
      position: Vector2(size.x / 2, 10),
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
    _enemyHealth.anchor = Anchor.topCenter;
    add(_enemyHealth);
  }

  // Update game state
  @override
  void update(double dt) {
    super.update(dt);
    _enemyActionTimer.update(dt);
    _gameOverTimer.update(dt);

    if (player.isRemoved && _playerDestroyed == false) {
      enemy.setMoveDirection(Vector2.zero());
      enemy.setMoveSpeed(0);
      _enemyActionTimer.stop();
      _playerDestroyed = true;
      _gameOverTimer.start();
    }

    if (enemy.isRemoved && _enemyDestroyed == false) {
      enemy.setMoveDirection(Vector2.zero());
      enemy.setMoveSpeed(0);
      _enemyActionTimer.stop();
      _enemyDestroyed = true;
      _gameOverTimer.start();
    }

    _playerScore.text = 'Score: ${player.score}';
    _playerHealth.text = 'Health: ${player.health}%';
    _enemyHealth.text = 'Health: ${enemy.health}%';
  }

  @override
  void render(Canvas canvas) {
    // Draw player health bar
    canvas.drawRect(
      Rect.fromLTWH(size.x - 108, size.y - 30, player.health.toDouble(), 20),
      Paint()..color = Colors.blueAccent,
    );

    // Draw enemy health bar
    canvas.drawRect(
      Rect.fromLTWH(size.x / 4, 10, enemy.health.toDouble() * 2, 20),
      Paint()..color = Colors.redAccent,
    );

    super.render(canvas);

    // Draw joystick
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

  // Create joystick when touching screen
  @override
  void onPanStart(DragStartInfo info) {
    if (!_playerDestroyed) {
      _pointerStartPosition = info.raw.globalPosition;
      _pointerCurrentPosition = info.raw.globalPosition;
    }
  }

  // Interact with the joystick
  @override
  void onPanUpdate(DragUpdateInfo info) {
    if (!_playerDestroyed) {
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
  }

  // Release the joystick
  @override
  void onPanEnd(DragEndInfo info) {
    _pointerStartPosition = null;
    _pointerCurrentPosition = null;
    player.setMoveDirection(Vector2.zero());
    player.setMoveSpeed(0);
  }

  // Shoot
  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    if (!_playerDestroyed) {
      PlayerBullet playerBullet = PlayerBullet(
        sprite: _spriteSheet.getSpriteById(28),
        size: Vector2(64, 64),
        position: player.position,
      );
      playerBullet.anchor = Anchor.center;
      add(playerBullet);
    }
  }

  // Enemy
  void _enemyAction() {
    bool negativedx = Random().nextBool();
    bool negativedy = Random().nextBool();
    bool shoot = Random().nextBool();
    double dx = Random().nextInt(60).toDouble();
    double dy = Random().nextInt(60).toDouble();
    double speed = Random().nextInt(5).toDouble();

    if (negativedx) {
      dx = dx * -1;
    }
    if (negativedy) {
      dy = dy * -1;
    }

    if (speed == 1) {
      speed = _movementSpeed1;
    } else if (speed == 2) {
      speed = _movementSpeed2;
    } else if (speed == 3) {
      speed = _movementSpeed3;
    } else if (speed == 4) {
      speed = _movementSpeed4;
    }

    enemy.setMoveDirection(Vector2(dx, dy));
    enemy.setMoveSpeed(speed);

    if (enemy.entranceComplete) {
      if (shoot) {
        EnemyBullet enemyBullet = EnemyBullet(
          sprite: _spriteSheet.getSpriteById(28),
          size: Vector2(64, 64),
          position: enemy.position,
        );
        enemyBullet.setMaxPosition(canvasSize[1]);
        enemyBullet.anchor = Anchor.center;
        add(enemyBullet);
      }
    }
  }

  void _showGameOverMessage() {
    _enemySpriteID = Random().nextInt(24);
    _enemySpawnPositionNegative = Random().nextBool();
    if (!_playerDestroyed && _enemyDestroyed) {
      enemy = Enemy(
          sprite: _spriteSheet.getSpriteById(_enemySpriteID),
          size: Vector2(64, 64),
          position: _enemySpawnPositionNegative
              ? Vector2(canvasSize[0] / 2, 100) + Vector2.random() * -200
              : Vector2(canvasSize[0] / 2, 100) + Vector2.random() * 200);
      enemy.setMaxPosition(canvasSize);
      enemy.anchor = Anchor.topCenter;
      add(enemy);
      _enemyDestroyed = false;
      _enemyActionTimer.start();
      _gameOverTimer.stop();
    } else if (_playerDestroyed && !_enemyDestroyed) {
      print("You lost...");
    } else if (_playerDestroyed && _enemyDestroyed) {
      print("It's a tie!");
    }
  }
}
