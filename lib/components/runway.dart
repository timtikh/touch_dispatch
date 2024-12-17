import 'package:flame/components.dart';
import 'package:flame/game.dart'; // Import FlameGame

class Runway extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad(); // Ensure the component is properly initialized
    sprite = await gameRef.loadSprite('runway.png');
    size = Vector2(200, 50);
    position = gameRef.size / 2 - Vector2(100, 25); // Center the runway
  }
}
