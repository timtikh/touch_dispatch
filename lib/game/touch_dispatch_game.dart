import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import '../components/runway.dart';
import '../components/plane.dart';

class TouchDispatchGame extends FlameGame {
  late Runway runway;
  double spawnRate = 10.0;
  double spawnTimer = 0.0;
  List<PlaneEntity> planes = []; // List to store planes

  @override
  Future<void> onLoad() async {
    super.onLoad();
    runway = Runway();
    add(runway);
    spawnPlane();
  }

  @override
  void update(double dt) {
    super.update(dt);
    spawnTimer += dt;

    if (spawnTimer >= spawnRate) {
      spawnTimer = 0;
      spawnPlane();
    }

    // Planes will move based on their own target positions
  }

  Future<void> spawnPlane() async {
    final planeSprite = await loadSprite('plane_colored.png');
    final plane = PlaneEntity()
      ..sprite = planeSprite
      ..position = Vector2(50, 50)
      ..size = Vector2(50, 50)
      ..flightNumber = 'Flight ${DateTime.now().millisecondsSinceEpoch % 1000}'
      ..height = 10000; // Default height

    planes.add(plane); // Add the plane to the list of planes
    add(plane);
  }
}
