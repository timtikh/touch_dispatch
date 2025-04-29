import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flame/game.dart';
import 'package:touch_dispatch/pages/game/state_managment/game_bloc.dart';
import 'package:touch_dispatch/pages/game/state_managment/game_state.dart';
import 'overlays/game_overlay.dart';
import 'game_logic/touch_dispatch_game.dart';

class GamePage extends StatelessWidget {
  final double spawnRate;

  const GamePage({super.key, this.spawnRate = 10.0});

  @override
  Widget build(BuildContext context) {
    final gameBloc = GameBloc();
    final game = TouchDispatchGame(gameBloc)..spawnRate = spawnRate;

    return MultiBlocProvider(
      providers: [
        BlocProvider<GameBloc>.value(value: gameBloc),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            GameWidget(game: game),
            GameOverlay(game: game),
          ],
        ),
      ),
    );
  }
}
