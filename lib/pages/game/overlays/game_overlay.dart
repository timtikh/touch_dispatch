import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:touch_dispatch/pages/game/overlays/pause_overlay.dart';
import 'package:touch_dispatch/pages/game/game_logic/touch_dispatch_game.dart';

import '../state_managment/game_bloc.dart';
import '../state_managment/game_event.dart';
import '../state_managment/game_state.dart';
import 'game_over_overlay.dart';

class GameOverlay extends StatelessWidget {
  final TouchDispatchGame game;

  const GameOverlay({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Always-visible flight info panel
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 300,
            height: 900,
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Flights Info',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16),
                          backgroundColor: Colors.blueAccent,
                        ),
                        onPressed: () {
                          context.read<GameBloc>().add(PauseGameEvent());
                        },
                        child: const Icon(Icons.pause, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: BlocBuilder<GameBloc, GameState>(
                    builder: (context, state) {
                      return ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        children: state.planes.map((plane) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  plane.flightNumber,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                ValueListenableBuilder<double>(
                                  valueListenable: plane.heightNotifier,
                                  builder: (_, height, __) {
                                    return Text(
                                      'Height: ${height.toStringAsFixed(0)} ft',
                                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                                    );
                                  },
                                ),
                                ValueListenableBuilder<double>(
                                  valueListenable: plane.orderedHeightNotifier,
                                  builder: (_, orderedHeight, __) {
                                    return Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove, size: 16),
                                          color: Colors.white,
                                          onPressed: () {
                                            plane.orderedHeightNotifier.value -= 500;
                                          },
                                        ),
                                        Text(
                                          'Ordered: ${orderedHeight.toStringAsFixed(0)} ft',
                                          style: const TextStyle(color: Colors.white60, fontSize: 12),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.add, size: 16),
                                          color: Colors.white,
                                          onPressed: () {
                                            plane.orderedHeightNotifier.value += 500;
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                ValueListenableBuilder<double>(
                                  valueListenable: plane.orderedHeightNotifier,
                                  builder: (_, orderedHeight, __) {
                                    return Text(
                                      '${plane.flightNumber} maintaining ${orderedHeight.toStringAsFixed(0)}',
                                      style: const TextStyle(color: Colors.blueAccent, fontSize: 12),
                                    );
                                  },
                                ),
                                const Divider(color: Colors.white24),
                              ],
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
        BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            if (state.isGameOver) {
              return GameOverOverlay(game: game);
            } else if (state.isPaused) {
              return PauseMenuOverlay(game: game);
            }
            return const SizedBox.shrink();
          },
        ),

      ],
    );
  }
}
