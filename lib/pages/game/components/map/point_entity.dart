import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PointEntity extends PositionComponent {
  late final TextComponent nameText;

  static const List<String> pointNames = [
    'GPK', 'ABC', 'XYZ', 'LMN', 'DEF',
    'TRQ', 'HJK', 'BWN', 'ZMT', 'PKR',
    'SXD', 'JVL', 'MRQ', 'ENY', 'VCT',
    'DPL', 'QEX', 'TBR', 'WAZ', 'FNH',
    'UVO', 'CKM', 'RYT', 'XPL', 'NEQ',
    'AGL', 'OBX', 'KMI', 'ZRF', 'HTQ',
  ];

  PointEntity({required Vector2 position, required String name}) {
    this.position = position;
    size = Vector2(20, 20);
    anchor = Anchor.center;

    nameText = TextComponent(
      text: name,
      anchor: Anchor.topCenter,
      position: Vector2(size.x / 2, size.y / 2 + 12),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(nameText);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, paint);
  }
}
