import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../components/plane/plane.dart';
import '../components/map/game_map.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state_managment/game_bloc.dart';
import '../state_managment/game_event.dart';
import 'dart:math';

class TouchDispatchGame extends FlameGame {
  final GameBloc bloc;
  TouchDispatchGame(this.bloc);

  final Random _random = Random();

  late GameMap gameMap;
  double spawnRate = 10.0;
  double spawnTimer = 0.0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    gameMap = GameMap();
    add(gameMap);
    spawnPlane();
  }

  @override
  void update(double dt) {
    if (!bloc.state.isPaused) {
      super.update(dt);
      spawnTimer += dt;

      if (spawnTimer >= spawnRate) {
        spawnTimer = 0;
        spawnPlane();
      }

      checkPlaneRunwayCollisions();
    }
  }


  Vector2 _getRandomCornerPosition() {
    final padding = 20.0; // safe offset from exact edges
    final sizeX = size.x;
    final sizeY = size.y;

    switch (_random.nextInt(4)) {
      case 0: // top-left
        return Vector2(padding, padding);
      case 1: // top-right
        return Vector2(sizeX - 50 - padding, padding);
      case 2: // bottom-left
        return Vector2(padding, sizeY - 50 - padding);
      case 3: // bottom-right
        return Vector2(sizeX - 50 - padding, sizeY - 50 - padding);
      default:
        return Vector2(padding, padding);
    }
  }


  Future<void> spawnPlane() async {
    final planeSprite = await loadSprite('plane_colored.png');
    final plane = PlaneEntity()
      ..sprite = planeSprite
      ..position = _getRandomCornerPosition()
      ..size = Vector2(50, 50)
      ..flightNumber = 'Flight ${DateTime.now().millisecondsSinceEpoch % 1000}'
      ..height = 10000;

    bloc.add(AddPlaneEvent(plane));
    add(plane);
  }

  void checkPlaneRunwayCollisions() {
    for (final plane in bloc.state.planes) {
      if (plane.toRect().overlaps(gameMap.runway.toRect())) {
        removePlane(plane);
      }
    }
  }

  void removePlane(PlaneEntity plane) {
    bloc.add(RemovePlaneEvent(plane));
    plane.removeFromParent();
  }

  void pauseGame() => bloc.add(PauseGameEvent());
  void resumeGame() => bloc.add(ResumeGameEvent());
}
