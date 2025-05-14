import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../components/plane/plane.dart';
import '../components/map/game_map.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/plane/plane_sprite.dart';
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

      checkPlaneCollisions();
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
    final planeSprite = await loadSprite('plane.png');

    final centerPos = gameMap.size / 2;

    final plane = PlaneEntity()
      ..planeSprite = PlaneSprite(sprite: planeSprite)
      ..position = _getRandomCornerPosition()
      ..size = Vector2(20, 20)
      ..flightNumber = 'Flight ${DateTime.now().millisecondsSinceEpoch % 1000}'
      ..height = 10000;


    plane.moveToPoint(centerPos);


    bloc.add(AddPlaneEvent(plane));
    add(plane);
  }

  void checkPlaneRunwayCollisions() {
    final runwayRect = gameMap.runway.toRect();
    final runwayCenter = gameMap.runway.position + gameMap.runway.size / 2;

    for (final plane in bloc.state.planes) {
      final planeRect = plane.toRect();
      final planeCenter = plane.position + plane.size / 2;

     // final isOverlapping = planeRect.overlaps(runwayRect);
      final isLowEnough = plane.heightNotifier.value < 200;

      // Check if the plane is roughly approaching the center of the runway
      final approachVector = (runwayCenter - planeCenter).normalized();
      final movementDirection = plane.direction.normalized();

      final alignmentThreshold = 0.8; // cosine of ~36 degrees
      //final dotProduct = approachVector.dot(movementDirection);

      if (isLowEnough) {
        removePlane(plane);
        bloc.add(PlaneLandedEvent(plane)); // Optional custom event
      }
    }
  }


  void checkPlaneCollisions() {
    final planes = bloc.state.planes;

    for (int i = 0; i < planes.length; i++) {
      for (int j = i + 1; j < planes.length; j++) {
        final planeA = planes[i];
        final planeB = planes[j];

        final horizontalCollision = planeA.toRect().overlaps(planeB.toRect());

        if (horizontalCollision) {
          final heightA = planeA.heightNotifier.value;
          final heightB = planeB.heightNotifier.value;
          final heightDifference = (heightA - heightB).abs();

          if (heightDifference <= 200) {
            bloc.add(GameOverEvent(reason: 'Mid-air collision'));
            return; // stop checking once collision is found
          }
        }
      }
    }
  }


  void removePlane(PlaneEntity plane) {
    bloc.add(RemovePlaneEvent(plane));
    plane.removeFromParent();

  }

  void pauseGame() => bloc.add(PauseGameEvent());
  void resumeGame() => bloc.add(ResumeGameEvent());
  void restart() {
    // Clear existing planes
    for (final plane in bloc.state.planes) {
      plane.removeFromParent();
    }
    bloc.add(RestartGameEvent()); // implement this in your bloc
    spawnPlane(); // start with one plane
  }

}
