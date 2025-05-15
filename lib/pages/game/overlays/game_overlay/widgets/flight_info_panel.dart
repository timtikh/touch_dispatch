import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../game_logic/touch_dispatch_game.dart';
import '../../../state_managment/game_bloc.dart';
import '../../../state_managment/game_state.dart';


class FlightInfoPanel extends StatelessWidget {
  final TouchDispatchGame game;

  const FlightInfoPanel({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.all(6),
      decoration: const BoxDecoration(color: Colors.black),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Flights Info', style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
          Expanded(
            child: BlocBuilder<GameBloc, GameState>(
              builder: (context, state) {
                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children: state.planes.map((plane) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plane.flightNumber,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        ValueListenableBuilder<double>(
                          valueListenable: plane.heightNotifier,
                          builder: (_, height, __) => Text(
                            'Height: ${height.toStringAsFixed(0)} ft',
                            style: const TextStyle(color: Colors.white70, fontSize: 11),
                          ),
                        ),
                        ValueListenableBuilder<double>(
                          valueListenable: plane.orderedHeightNotifier,
                          builder: (_, orderedHeight, __) => Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove, size: 14),
                                color: Colors.white,
                                padding: EdgeInsets.zero,
                                onPressed: () => plane.orderedHeightNotifier.value -= 500,
                              ),
                              Text(
                                'Ordered: ${orderedHeight.toStringAsFixed(0)} ft',
                                style: const TextStyle(color: Colors.white60, fontSize: 11),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add, size: 14),
                                color: Colors.white,
                                padding: EdgeInsets.zero,
                                onPressed: () => plane.orderedHeightNotifier.value += 500,
                              ),
                            ],
                          ),
                        ),
                        Wrap(
                          children: game.gameMap.points.map((point) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 2),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                  minimumSize: Size(0, 0),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                  backgroundColor: Colors.blueGrey,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                ),
                                onPressed: () => plane.moveToPoint(point.position),
                                child: Text(
                                  point.nameText.text,
                                  style: const TextStyle(color: Colors.white, fontSize: 9),
                                ),
                              ),

                            );
                          }).toList(),
                        ),
                        const Divider(color: Colors.white24),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
