import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'runway.dart';
import 'point_entity.dart';

class GameMap extends PositionComponent with HasGameRef<FlameGame> {
  late Runway runway;
  final List<PointEntity> points = [];

  final Random random = Random();
  final int minPoints = 12;
  final int maxPoints = 20;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    size = gameRef.size; // Use the size of the viewport
    anchor = Anchor.topLeft;

    // Centered runway
    runway = Runway()
      ..position = Vector2(size.x / 2, size.y / 2)
      ..anchor = Anchor.center
      ..size = Vector2(200, 50);
    add(runway);

    // Get unique names
    List<String> availableNames = List.from(PointEntity.pointNames)..shuffle();
    int numberOfPoints = minPoints + random.nextInt(maxPoints - minPoints + 1);

    for (int i = 0; i < numberOfPoints; i++) {
      final position = Vector2(
        random.nextDouble() * size.x,
        random.nextDouble() * size.y,
      );
      final name = availableNames.removeLast();

      final point = PointEntity(position: position, name: name);
      points.add(point);
      add(point);
    }
  }
}
