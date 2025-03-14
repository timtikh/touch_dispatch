import 'dart:ui';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../point_entity.dart';

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
  int currentPathIndex = 0;
  bool isFollowingPath = false;

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
      if (currentPathIndex < pathPoints.length) {
        Vector2 target = pathPoints[currentPathIndex];
        Vector2 direction = target - position;

        if (direction.length > 5) {
          velocity = direction.normalized() * speed;
          position += velocity * dt;
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

    height -= 10 * dt;
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


  // Update onDragUpdate to store points
  @override
  void onDragUpdate(DragUpdateEvent event) {
    targetPosition = event.localStartPosition - dragDelta;
    dragPath.lineTo(event.localStartPosition.x, event.localStartPosition.y);
    // Store point every few pixels to optimize path following
    if (pathPoints.isEmpty ||
        pathPoints.last.distanceTo(event.localStartPosition) > 10) {
      pathPoints.add(event.localStartPosition.clone());
    }
  }

  // Update onDragStart to reset path
  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    dragDelta = event.localPosition - position;
    isBeingDragged = true;
    // Clear both the visual path and path points
    dragPath = Path(); // Create new path instead of just moving to point
    dragPath.moveTo(event.localPosition.x, event.localPosition.y);
    pathPoints.clear();
    pathPoints.add(event.localPosition.clone());
    currentPathIndex = 0;
    isFollowingPath = false; // Reset following state
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
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawPath(dragPath, paint);
  }

  Rect toRect() {
    return Rect.fromLTWH(position.x, position.y, size.x, size.y);
  }
}