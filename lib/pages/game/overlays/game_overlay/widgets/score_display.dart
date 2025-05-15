import 'package:flutter/material.dart';

import '../../../state_managment/game_bloc.dart';
import '../../../state_managment/game_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreDisplay extends StatelessWidget {
  const ScoreDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green[700],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Score: ${state.score}', // Bind the score from GameState
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        );
      },
    );
  }
}
