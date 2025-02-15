import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class PlaneEntity extends SpriteComponent with DragCallbacks {
  final double speed = 100;
  late TextComponent flightText;
  late TextComponent heightText;
  String flightNumber = 'Flight 123';
  double height = 10000;
  Vector2 dragDelta =
      Vector2.zero(); // Store drag delta for position adjustments
  late Sprite planeSprite;
  Vector2 targetPosition = Vector2.zero(); // Target position after drag
  Vector2 velocity = Vector2.zero(); // Velocity for plane movement
  final Random random = Random(); // Random for direction
  bool isBeingDragged = false; // Track if plane is being dragged
  double randomMoveDuration = 5.0; // Time in seconds for random movement
  double timeUntilDirectionChange = 0.0;

  @override
  Future<void> onLoad() async {
    size = Vector2(50, 50);

    // Set initial target position to current position
    targetPosition = position;

    // Add flight number text
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

    // Add height text
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

    // Initialize random direction movement
    _setRandomVelocity();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!isBeingDragged) {
      // Update position based on velocity
      position += velocity * dt;

      // Reduce the time until the direction should change
      timeUntilDirectionChange -= dt;
      if (timeUntilDirectionChange <= 0) {
        _setRandomVelocity();
      }

      // Ensure the plane stays within bounds by reversing direction if it reaches the edge
      if (position.x < 0 ||
          position.x > size.x ||
          position.y < 0 ||
          position.y > size.y) {
        _setRandomVelocity();
      }
    } else {
      // Move toward the dragged position
      Vector2 direction = targetPosition - position;

      if (direction.length > 1) {
        // Ensure the plane doesn't jitter around the target position
        velocity = direction.normalized() * speed * 0.5;
        position += velocity * dt;
      }
    }

    // Decrease height over time
    height -= 10 * dt;
    heightText.text = 'Height: ${height.toStringAsFixed(0)} ft';
  }

  void _setRandomVelocity() {
    // Set a random velocity for random movement and a random time for direction change
    double angle = random.nextDouble() * 2 * pi; // Random angle in radians
    velocity = Vector2(cos(angle), sin(angle)) * speed * 0.2;
    timeUntilDirectionChange =
        randomMoveDuration + random.nextDouble() * 2; // Vary movement duration
  }

  @override
  void onDragStart(DragStartEvent event) {
    // Capture the drag start event
    dragDelta = event.localPosition - position;
    isBeingDragged = true;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    // Set the new target position based on drag
    targetPosition = event.localPosition - dragDelta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    // After drag ends, move toward the last dragged position, then resume random movement
    isBeingDragged = false;
    _setRandomVelocity(); // Resume random movement after reaching the final drag point
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    // Handle when drag is canceled
    isBeingDragged = false;
    _setRandomVelocity(); // Resume random movement
  }

  // Convert the plane to a rectangle (bounding box) for collision detection
  Rect toRect() {
    return Rect.fromLTWH(position.x, position.y, size.x, size.y);
  }
}
