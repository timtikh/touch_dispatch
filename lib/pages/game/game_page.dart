
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'overlays/game_overlay.dart';
import 'game_logic/touch_dispatch_game.dart';

class GamePage extends StatelessWidget {
  final double spawnRate;

  const GamePage({this.spawnRate = 10.0});

  @override
  Widget build(BuildContext context) {
    final game = TouchDispatchGame()..spawnRate = spawnRate;
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: game),
          GameOverlay(game: game),
        ],
      ),
    );
  }
}