import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:space_battles/game/enemy_bullet.dart';
import 'package:space_battles/game/game.dart';

/// [Player] Creates and handles a that represents the player
class Player extends SpriteComponent
    with CollisionCallbacks, HasGameRef<SpaceBattlesGame> {
  Vector2 _maxPosition = Vector2.zero();
  Vector2 _moveDirection = Vector2.zero();
  double _speed = 0;
  int score = 0;
  int health = 100;
  final int _damageTaken = 5;

  Player({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size);

  Vector2 getRandomVectorForThruster() {
    return (Vector2.random() - Vector2(0.5, -1)) * 250;
  }

  Vector2 getRandomVectorForExplosion() {
    return (Vector2.random() - Vector2.random()) * 500;
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

    if (other is EnemyBullet) {
      if (health > _damageTaken) {
        health = health - _damageTaken;
      } else {
        removeFromParent();
        gameRef.audioPlayerComponent.playSFX('laser1.ogg');
        health = health - _damageTaken;
        if (health < 0) {
          health = 0;
        }
        final particleComponent = ParticleSystemComponent(
          particle: Particle.generate(
            count: 50,
            lifespan: 5,
            generator: (i) => AcceleratedParticle(
              acceleration: getRandomVectorForExplosion(),
              speed: getRandomVectorForExplosion(),
              position: position.clone(),
              child: CircleParticle(
                radius: 2,
                paint: Paint()..color = Colors.white,
              ),
            ),
          ),
        );
        gameRef.add(particleComponent);
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += _moveDirection.normalized() * _speed * dt;

    position.clamp(
      Vector2(size[0], _maxPosition[1] / 1.6),
      Vector2(_maxPosition[0] - size[0], _maxPosition[1] - size[1]),
    );

    final particleComponent = ParticleSystemComponent(
      particle: Particle.generate(
        count: 10,
        lifespan: 0.1,
        generator: (i) => AcceleratedParticle(
          acceleration: getRandomVectorForThruster(),
          speed: getRandomVectorForThruster(),
          position: position.clone() + Vector2(0, size.y / 100),
          child: CircleParticle(
            radius: 1,
            paint: Paint()..color = Colors.white,
          ),
        ),
      ),
    );

    gameRef.add(particleComponent);
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
