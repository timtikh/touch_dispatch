import 'dart:ui';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:touch_dispatch/pages/game/components/plane/plane_sprite.dart';

import '../map/point_entity.dart';

class PlaneEntity extends PositionComponent with DragCallbacks {
  final double speed = 100;
  late TextComponent flightText;
  late TextComponent heightText;
  String flightNumber = 'Flight 123';
  double height = 10000;
  final ValueNotifier<double> heightNotifier = ValueNotifier(10000);
  final ValueNotifier<double> orderedHeightNotifier = ValueNotifier(10000);
  Vector2 get direction => velocity.normalized();

  Vector2 dragDelta = Vector2.zero();
  late PlaneSprite planeSprite;
  Vector2 targetPosition = Vector2.zero();
  Vector2 velocity = Vector2.zero();

  final Random random = Random();
  bool isBeingDragged = false;
  bool isMovingTowardsSmth = false;
  double randomMoveDuration = 30.0;
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
    await super.onLoad();

    add(planeSprite); // Add sprite as a child

    size = Vector2(50, 50);
    targetPosition = position;

    orderedHeightNotifier.value = height;
    heightNotifier.value = height;

    flightText = TextComponent(
      text: flightNumber,
      anchor: Anchor.center,
      position: Vector2(0, -20),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(flightText);

    heightText = TextComponent(
      text: 'Height: ${height.toStringAsFixed(0)} ft',
      anchor: Anchor.center,
      position: Vector2(0, 20),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
    add(heightText);

    //_setRandomVelocity();
  }


  @override
  void update(double dt) {
    super.update(dt);
    planeSprite.updateDirection(velocity);

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
          velocity = direction.normalized() * speed * 0.4;

          position += velocity * dt / 2;
        } else {
          currentPathIndex++;
        }
      } else {
        isFollowingPath = false;
        _setRandomVelocity();
      }
    } else if (isMovingTowardsSmth) {
      position += velocity * dt;
    }
    else if (!isBeingDragged) {
      position += velocity * dt;
      timeUntilDirectionChange -= dt;
      if (timeUntilDirectionChange <= 0) {
        _setRandomVelocity();
      }
    }

    // Smooth climb/descent
    const double climbRate = 300.0; // feet per second
    if ((height - orderedHeightNotifier.value).abs() > 10) {
      double delta = orderedHeightNotifier.value - height;
      double step = climbRate * dt;
      height += delta.sign * min(step, delta.abs());
    }

    heightNotifier.value = height;
    heightText.text = 'Height: ${height.toStringAsFixed(0)} ft';
  }

// Replace _setRandomVelocity
  void _setRandomVelocity() {
    timeUntilDirectionChange = randomMoveDuration + random.nextDouble() * 2;
    double angle = random.nextDouble() * 2 * pi;
    moveInDirection(Vector2(cos(angle), sin(angle)));
  }

// New method to follow a fixed direction
  void moveInDirection(Vector2 dir) {
    velocity = dir.normalized() * speed * 0.2;
    isFollowingPath = false;
    targetPoint = null;
  }

  void moveToPoint(Vector2 point) {
    targetPosition = point;
    isMovingTowardsSmth = true;
    final delta = point - position;
    final angle = atan2(delta.y, delta.x);
    moveInDirection(Vector2(cos(angle), sin(angle)));
  }




  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);

    isBeingDragged = true;
    dragPath = Path();

    final pos = absolutePosition;

    pathPoints.clear();
    pathPoints.add(pos.clone());

    currentPathIndex = 0;
    isFollowingPath = false;
  }


  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);

    final pos = event.canvasStartPosition;
    dragPath.lineTo(pos.x, pos.y);

    if (pathPoints.isEmpty || pathPoints.last.distanceTo(pos) > 10) {
      pathPoints.add(pos.clone());
    }
  }



  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    isBeingDragged = false;
    if (pathPoints.length > 1) {
      isFollowingPath = true;
      currentPathIndex = 0;
      _createDashedPath();
    }
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