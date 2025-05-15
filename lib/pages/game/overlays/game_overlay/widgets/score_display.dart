import 'package:flutter/material.dart';

class ScoreDisplay extends StatelessWidget {
  const ScoreDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green[700],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Score: 0', // TODO: bind with real score from GameState
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
