import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'game/touch_dispatch_game.dart';

void main() {
  runApp(GameWidget(game: TouchDispatchGame()));
}
