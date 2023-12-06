import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_battles/game/enemy_bullet.dart';

class Player extends SpriteComponent with CollisionCallbacks {
  Vector2 _maxPosition = Vector2.zero();
  Vector2 _moveDirection = Vector2.zero();
  double _speed = 0;

  Player({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size);

  @override
  void onMount() {
    super.onMount();

    final shape = CircleHitbox();
    add(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is EnemyBullet) {
      removeFromParent();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += _moveDirection.normalized() * _speed * dt;

    position.clamp(
      Vector2(size[0], _maxPosition[1] / 1.6),
      Vector2(_maxPosition[0] - size[0], _maxPosition[1]),
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
