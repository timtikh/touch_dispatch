import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../state_managment/game_bloc.dart';
import '../../../state_managment/game_event.dart';

class PauseButton extends StatelessWidget {
  const PauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(14),
        backgroundColor: Colors.blueAccent,
      ),
      onPressed: () => context.read<GameBloc>().add(PauseGameEvent()),
      child: const Icon(Icons.pause, color: Colors.white),
    );
  }
}
