import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'game/game_overlay.dart';
import 'game/touch_dispatch_game.dart';

// Main App
void main() {
  final game = TouchDispatchGame();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            GameWidget(game: game), // The game canvas
            GameOverlay(game: game), // The HUD overlay
          ],
        ),
      ),
    ),
  );
}
