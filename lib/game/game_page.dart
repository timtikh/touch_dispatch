
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game_overlay.dart';
import 'touch_dispatch_game.dart';
import '../main.dart'; // Import the main file to navigate to the game screen

class GamePage extends StatelessWidget {
  final game = TouchDispatchGame();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: game), // The game canvas
          GameOverlay(game: game), // The HUD overlay
        ],
      ),
    );
  }
}


