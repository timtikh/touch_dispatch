import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../components/plane/plane.dart';
import '../components/map/game_map.dart';

class GameMethods extends FlameGame {
  /*ValueNotifier<List<PlaneEntity>> planesNotifier = ValueNotifier([]);

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
  */

}