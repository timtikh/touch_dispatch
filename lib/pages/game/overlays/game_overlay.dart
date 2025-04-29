import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:touch_dispatch/pages/game/overlays/pause_overlay.dart';
import 'package:touch_dispatch/pages/game/game_logic/touch_dispatch_game.dart';

import '../state_managment/game_bloc.dart';
import '../state_managment/game_state.dart';

class GameOverlay extends StatelessWidget {
  final TouchDispatchGame game;

  const GameOverlay({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Flight info panel
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            width: 200,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Flights Info',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<GameBloc, GameState>(
                    builder: (context, state) {
                      return ListView(
                        children: state.planes.map((plane) {
                          return ListTile(
                            title: Text(
                              plane.flightNumber,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Height: ${plane.height.toStringAsFixed(0)} ft',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        // Pause button
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocBuilder<GameBloc, GameState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (state.isPaused) {
                      game.resumeGame();
                    } else {
                      game.pauseGame();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.all(20),
                  ),
                  child: Icon(
                    state.isPaused ? Icons.play_arrow : Icons.pause,
                  ),
                );
              },
            ),
          ),
        ),
        // Pause overlay
        BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            if (state.isPaused) {
              return PauseMenuOverlay(game: game);
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
