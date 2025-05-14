import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PointEntity extends PositionComponent {
  late TextComponent nameText;
  static const List<String> pointNames = [
    'GPK', 'ABC', 'XYZ', 'LMN', 'DEF',
    'TRQ', 'HJK', 'BWN', 'ZMT', 'PKR',
    'SXD', 'JVL', 'MRQ', 'ENY', 'VCT',
    'DPL', 'QEX', 'TBR', 'WAZ', 'FNH',
    'UVO', 'CKM', 'RYT', 'XPL', 'NEQ',
    'AGL', 'OBX', 'KMI', 'ZRF', 'HTQ'
  ];
  final Random random = Random();

  PointEntity({required Vector2 position}) {
    this.position = position;
    size = Vector2(20, 20);

    // Generate a random point name
    String pointName = pointNames[random.nextInt(pointNames.length)];

    // Add text component
    nameText = TextComponent(
      text: pointName,
      position: Vector2(size.x / 2, size.y / 2 + 20), // Center the text
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(nameText);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, paint);
  }
}