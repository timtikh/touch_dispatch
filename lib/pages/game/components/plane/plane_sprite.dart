import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

class PlaneSprite extends SpriteComponent {
  PlaneSprite({
    required Sprite sprite,
    Vector2? size,
  }) : super(
    sprite: sprite,
    size: size ?? Vector2.all(20),
    anchor: Anchor.center,
  );
  double offset = pi/4;
  void updateDirection(Vector2 velocity) {
    if (velocity.length > 1e-2) {
      angle = -velocity.angleToSigned(Vector2(1, 0)) + offset;
    }
  }
}
