import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_battles/game/player.dart';

class EnemyBullet extends SpriteComponent with CollisionCallbacks {
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
  void onMount() {
    super.onMount();

    final shape = CircleHitbox();
    add(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Player) {
      removeFromParent();
    }
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
