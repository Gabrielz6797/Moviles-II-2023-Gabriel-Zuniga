import 'package:flame/components.dart';

class PlayerBullet extends SpriteComponent {
  final double _speed = 450;

  PlayerBullet({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size);

  @override
  void update(double dt) {
    super.update(dt);
    position = position + Vector2(0, -1) * _speed * dt;

    if (position.y < 0) {
      removeFromParent();
    }
  }
}
