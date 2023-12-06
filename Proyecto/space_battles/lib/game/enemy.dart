import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:space_battles/game/game.dart';
import 'package:space_battles/game/player_bullet.dart';

class Enemy extends SpriteComponent
    with CollisionCallbacks, HasGameRef<SpaceBattlesGame> {
  Vector2 _maxPosition = Vector2.zero();
  Vector2 _moveDirection = Vector2.zero();
  Vector2 _finalSize = Vector2.zero();
  double _speed = 0;
  bool entranceComplete = false;
  int health = 100;
  final int _damageTaken = 10;

  Enemy({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: Vector2(0, 0)) {
    angle = pi;
    _finalSize = size!;
  }

  Vector2 getRandomVectorForThruster() {
    return (Vector2.random() - Vector2(0.5, 2)) * 250;
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

    if (other is PlayerBullet && entranceComplete) {
      if (health > _damageTaken) {
        health = health - _damageTaken;
      } else {
        removeFromParent();
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
        gameRef.player.score += 5;
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += _moveDirection.normalized() * _speed * dt;

    position.clamp(
      Vector2(size[0], size[1] * 2),
      Vector2(_maxPosition[0] - size[0], _maxPosition[1] / 2.2),
    );

    if (entranceComplete) {
      final particleComponent = ParticleSystemComponent(
        particle: Particle.generate(
          count: 10,
          lifespan: 0.1,
          generator: (i) => AcceleratedParticle(
            acceleration: getRandomVectorForThruster(),
            speed: getRandomVectorForThruster(),
            position: position.clone() - Vector2(0, size.y),
            child: CircleParticle(
              radius: 1,
              paint: Paint()..color = Colors.white,
            ),
          ),
        ),
      );

      gameRef.add(particleComponent);
    } else {
      entranceAnimation(size, _finalSize);
    }
  }

  entranceAnimation(Vector2 actualSize, Vector2 finalSize) {
    if (actualSize[0] < finalSize[0] && actualSize[1] < finalSize[1]) {
      actualSize[0] = actualSize[0] + 1;
      actualSize[1] = actualSize[1] + 1;
    } else {
      entranceComplete = true;
    }
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
