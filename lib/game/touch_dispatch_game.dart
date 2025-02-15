import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../components/runway.dart';
import '../components/plane.dart';
import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../components/runway.dart';
import '../components/plane.dart';
import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import '../components/runway.dart';
import '../components/plane.dart';
import 'dart:async';

class TouchDispatchGame extends FlameGame {
  late Runway runway;
  double spawnRate = 10.0;
  double spawnTimer = 0.0;
  ValueNotifier<List<PlaneEntity>> planesNotifier =
      ValueNotifier([]); // ValueNotifier for planes

  bool isPaused = false; // Track if the game is paused

  @override
  Future<void> onLoad() async {
    super.onLoad();
    runway = Runway();
    add(runway);
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

      // Check for collisions between planes and the runway
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
      ..height = 10000; // Default height

    planesNotifier.value = List.from(planesNotifier.value)
      ..add(plane); // Notify planes change
    add(plane);
  }

  // Check if any plane is flying over the runway
  void checkPlaneRunwayCollisions() {
    for (final plane in planesNotifier.value) {
      if (plane.toRect().overlaps(runway.toRect())) {
        // Remove the plane from the game if it collides with the runway
        removePlane(plane);
      }
    }
  }

  void removePlane(PlaneEntity plane) {
    planesNotifier.value = List.from(planesNotifier.value)
      ..remove(plane); // Update notifier
    plane.removeFromParent(); // Remove the plane from the game
  }

  // Pause the game logic
  void pauseGame() {
    isPaused = true;
    pauseEngine();
  }

  // Resume the game logic
  void resumeGame() {
    isPaused = false;
    resumeEngine();
  }

  // Get a list of widgets displaying the flight information for the HUD
  List<Widget> getFlightInfoWidgets() {
    return planesNotifier.value.map((plane) {
      return ListTile(
        title: Text(plane.flightNumber),
        subtitle: Text('Height: ${plane.height.toStringAsFixed(0)} ft'),
      );
    }).toList();
  }
}
