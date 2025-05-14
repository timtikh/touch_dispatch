import 'dart:ui';
import 'package:flame/components.dart';

class LineComponent extends ShapeComponent {
  final Vector2 begin;
  final Vector2 end;
  final Paint linePaint;

  LineComponent({
    required this.begin,
    required this.end,
    required Paint paint,
  }) : linePaint = paint {
    position = Vector2.zero();
    size = Vector2.zero(); // Not used
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawLine(begin.toOffset(), end.toOffset(), linePaint);
  }
}
