import 'dart:ui';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../map/point_entity.dart';

class PlaneEntity extends SpriteComponent with DragCallbacks {
  final double speed = 100;
  late TextComponent flightText;
  late TextComponent heightText;
  String flightNumber = 'Flight 123';
  double height = 10000;
  Vector2 dragDelta = Vector2.zero();
  late Sprite planeSprite;
  Vector2 targetPosition = Vector2.zero();
  Vector2 velocity = Vector2.zero();
  final Random random = Random();
  bool isBeingDragged = false;
  double randomMoveDuration = 5.0;
  double timeUntilDirectionChange = 0.0;
  Path dragPath = Path();
  PointEntity? targetPoint;

  List<Vector2> pathPoints = [];
  int currentPathIndex = 3;
  bool isFollowingPath = false;

  final Path _dashPath = Path();
  final double _dashLength = 10;
  final double _gapLength = 5;

  void _createDashedPath() {
    _dashPath.reset();
    if (pathPoints.isEmpty) return;

    for (int i = 0; i < pathPoints.length - 1; i++) {
      Vector2 start = pathPoints[i];
      Vector2 end = pathPoints[i + 1];
      Vector2 direction = end - start;
      double distance = direction.length;
      Vector2 normalized = direction.normalized();

      double drawn = 0;
      bool isDash = true;

      while (drawn < distance) {
        double segmentLength = isDash ? _dashLength : _gapLength;
        segmentLength = min(segmentLength, distance - drawn);

        Vector2 segmentStart = start + normalized * drawn;
        Vector2 segmentEnd = segmentStart + normalized * segmentLength;

        if (isDash) {
          if (drawn == 0) {
            _dashPath.moveTo(segmentStart.x, segmentStart.y);
          }
          _dashPath.lineTo(segmentEnd.x, segmentEnd.y);
        }

        drawn += segmentLength;
        isDash = !isDash;
      }
    }
  }



  @override
  Future<void> onLoad() async {
    size = Vector2(50, 50);
    targetPosition = position;

    flightText = TextComponent(
      text: flightNumber,
      position: position + Vector2(-20, -70),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(flightText);

    heightText = TextComponent(
      text: 'Height: ${height.toStringAsFixed(0)} ft',
      position: position + Vector2(-20, 20),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(heightText);


    _setRandomVelocity();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isFollowingPath && pathPoints.isNotEmpty) {
      while (currentPathIndex > 0 && pathPoints.isNotEmpty) {
        pathPoints.removeAt(0);
        currentPathIndex--;
      }
      _createDashedPath();
      if (currentPathIndex < pathPoints.length) {
        Vector2 target = pathPoints[currentPathIndex];
        Vector2 direction = target - position;

        if (direction.length > 5) {
          velocity = direction.normalized() * speed;
          position += velocity * dt /2;
        } else {
          currentPathIndex++;
        }
      } else {
        isFollowingPath = false;
        _setRandomVelocity();
      }
    } else if (!isBeingDragged) {
      position += velocity * dt;
      timeUntilDirectionChange -= dt;
      if (timeUntilDirectionChange <= 0) {
        _setRandomVelocity();
      }
    }

    //height -= 10 * dt;
    heightText.text = 'Height: ${height.toStringAsFixed(0)} ft';
  }



  void _setRandomVelocity() {
    double angle = random.nextDouble() * 2 * pi;
    velocity = Vector2(cos(angle), sin(angle)) * speed * 0.2;
    timeUntilDirectionChange = randomMoveDuration + random.nextDouble() * 2;
  }

  void setTargetPoint(PointEntity point) {
    targetPoint = point;
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    // Calculate delta between touch point and current position
    dragDelta = event.localPosition;
    isBeingDragged = true;
    dragPath = Path();
    dragPath.moveTo(event.canvasPosition.x, event.canvasPosition.y);
    pathPoints.clear();
    pathPoints.add(event.canvasPosition.clone());
    currentPathIndex = 0;
    isFollowingPath = false;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    // Use canvas position for actual movement
    targetPosition = event.canvasPosition - dragDelta;
    dragPath.lineTo(event.canvasPosition.x, event.canvasPosition.y);
    if (pathPoints.isEmpty ||
        pathPoints.last.distanceTo(event.canvasPosition) > 10) {
      pathPoints.add(event.canvasPosition.clone());
    }
  }

  // Update onDragEnd to start path following
  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    isBeingDragged = false;
    isFollowingPath = true;
    currentPathIndex = 0;
  }


  @override
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    isBeingDragged = false;
    isFollowingPath = false;
    _setRandomVelocity();
  }


  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Draw path
    Paint paint = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.save();
    canvas.translate(-position.x, -position.y);
    canvas.drawPath(_dashPath, paint);
    canvas.restore();
  }

  Rect toRect() {
    return Rect.fromLTWH(position.x, position.y, size.x, size.y);
  }

}