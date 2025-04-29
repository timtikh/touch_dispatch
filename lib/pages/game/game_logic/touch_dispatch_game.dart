import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../components/plane/plane.dart';
import '../components/map/game_map.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state_managment/game_bloc.dart';
import '../state_managment/game_event.dart';

class TouchDispatchGame extends FlameGame {
  final GameBloc bloc;
  TouchDispatchGame(this.bloc);

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

  Future<void> spawnPlane() async {
    final planeSprite = await loadSprite('plane_colored.png');
    final plane = PlaneEntity()
      ..sprite = planeSprite
      ..position = Vector2(50, 50)
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
