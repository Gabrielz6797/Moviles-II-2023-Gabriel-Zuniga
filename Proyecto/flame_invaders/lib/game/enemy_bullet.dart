import 'dart:math';
import 'package:flame/components.dart';

class EnemyBullet extends SpriteComponent {
  double _maxPosition = 0;
  final double _speed = 450;

  EnemyBullet({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size) {
    angle = pi;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position = position + Vector2(0, 1) * _speed * dt;

    if (position.y > _maxPosition) {
      removeFromParent();
    }
  }

  setMaxPosition(double newMaxPosition) {
    _maxPosition = newMaxPosition;
  }
}
