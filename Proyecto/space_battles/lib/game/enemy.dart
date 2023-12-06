import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_battles/game/player_bullet.dart';

class Enemy extends SpriteComponent with CollisionCallbacks {
  Vector2 _maxPosition = Vector2.zero();
  Vector2 _moveDirection = Vector2.zero();
  double _speed = 0;

  Enemy({
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

    if (other is PlayerBullet) {
      removeFromParent();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += _moveDirection.normalized() * _speed * dt;

    position.clamp(
      Vector2(size[0], size[1]),
      Vector2(_maxPosition[0] - size[0], _maxPosition[1] / 2.2),
    );
  }

  setMaxPosition(Vector2 newMaxPosition) {
    _maxPosition = newMaxPosition;
  }

  setMoveDirection(Vector2 newMoveDirection) {
    _moveDirection = newMoveDirection;
  }

  setMoveSpeed(double newSpeed) {
    _speed = newSpeed;
  }
}
