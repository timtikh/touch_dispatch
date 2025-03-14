import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'components/plane/plane.dart';
import 'components/game_map.dart';

class TouchDispatchGame extends FlameGame {
  late GameMap gameMap;
  double spawnRate = 10.0;
  double spawnTimer = 0.0;
  ValueNotifier<List<PlaneEntity>> planesNotifier = ValueNotifier([]);
  bool isPaused = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    gameMap = GameMap();
    add(gameMap);
    spawnPlane();
  }

  @override
  void update(double dt) {
    if (!isPaused) {
      super.update(dt);
      spawnTimer += dt;

      if (spawnTimer >= spawnRate) {
        spawnTimer = 0;
        spawnPlane();
      }

      checkPlaneRunwayCollisions();
    }
  }

  Future<void> spawnPlane() async {
    final planeSprite = await loadSprite('plane_colored.png');
    final plane = PlaneEntity()
      ..sprite = planeSprite
      ..position = Vector2(50, 50)
      ..size = Vector2(50, 50)
      ..flightNumber = 'Flight ${DateTime.now().millisecondsSinceEpoch % 1000}'
      ..height = 10000;

    planesNotifier.value = List.from(planesNotifier.value)..add(plane);
    add(plane);

  }

  void checkPlaneRunwayCollisions() {
    for (final plane in planesNotifier.value) {
      if (plane.toRect().overlaps(gameMap.runway.toRect())) {
        removePlane(plane);
      }
    }
  }

  void removePlane(PlaneEntity plane) {
    planesNotifier.value = List.from(planesNotifier.value)..remove(plane);
    plane.removeFromParent();
  }

  void pauseGame() {
    isPaused = true;
    pauseEngine();
  }

  void resumeGame() {
    isPaused = false;
    resumeEngine();
  }

  List<Widget> getFlightInfoWidgets() {
    return planesNotifier.value.map((plane) {
      return ListTile(
        title: Text(plane.flightNumber),
        subtitle: Text('Height: ${plane.height.toStringAsFixed(0)} ft'),
      );
    }).toList();
  }
}