import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'runway.dart';
import 'point_entity.dart';

class GameMap extends PositionComponent {
  late Runway runway;
  List<PointEntity> points = [];

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(800, 600); // Set the size of the game map

    // Add the runway
    runway = Runway()
      ..position = Vector2(size.x / 2, size.y - 100)
      ..size = Vector2(200, 50);
    add(runway);

    // Add some points on the map
    points.add(PointEntity(position: Vector2(100, 100)));
    points.add(PointEntity(position: Vector2(700, 100)));
    points.add(PointEntity(position: Vector2(400, 300)));

    for (var point in points) {
      add(point);
    }
  }
}