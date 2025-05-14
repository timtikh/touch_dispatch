import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'line_component.dart';
import 'map_colors.dart';
import 'runway.dart';
import 'point_entity.dart';

class GameMap extends PositionComponent with HasGameReference<FlameGame> {
  late Runway runway;
  final List<PointEntity> points = [];
  final Random random = Random();

  final int minPoints = 12;
  final int maxPoints = 20;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = game.size;
    anchor = Anchor.topLeft;

    _addRivers();
    _addAerodromeFence();

    _addRunway();
    _addPoints();
  }

  void _addRunway() {
    runway = Runway()
      ..position = size / 2
      ..anchor = Anchor.center
      ..size = Vector2(200, 20);
    add(runway);
  }

  void _addPoints() {
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

  void _addRivers() {
    for (int i = 0; i < 2; i++) {
      final start = Vector2(
        random.nextDouble() * size.x,
        0,
      );
      final end = Vector2(
        random.nextDouble() * size.x,
        size.y,
      );
      final path = LineComponent(
        begin: start,
        end: end,
        paint: Paint()
          ..color = MapColors.river
          ..strokeWidth = 3,
      );
      add(path);
    }
  }

  void _addAerodromeFence() {
    final padding = 40.0;
    final fenceRect = RectangleComponent(
      position: Vector2(padding, padding),
      size: size - Vector2.all(padding * 2),
      paint: Paint()
        ..color = MapColors.fence
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
    add(fenceRect);
  }
}
