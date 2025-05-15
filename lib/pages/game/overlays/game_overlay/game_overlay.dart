import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:touch_dispatch/pages/game/overlays/game_overlay/widgets/flight_info_panel.dart';
import '../../game_logic/touch_dispatch_game.dart';
import '../../state_managment/game_bloc.dart';
import '../../state_managment/game_state.dart';
import '../game_over_overlay.dart';
import '../pause_overlay.dart';
import 'buttons/info_button.dart';
import 'buttons/pause_button.dart';
import 'widgets/score_display.dart';
class GameOverlay extends StatelessWidget {
  final TouchDispatchGame game;

  const GameOverlay({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 300,
        margin: const EdgeInsets.all(4),
        child: Column(
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                ScoreDisplay(),
                SizedBox(width: 8),
                InfoButton(),
                SizedBox(width: 6),
                PauseButton(),
              ],
            ),
            BlocBuilder<GameBloc, GameState>(
              builder: (context, state) {
                if (state.isGameOver) return GameOverOverlay(game: game);
                if (state.isPaused) return PauseMenuOverlay(game: game);
                return Expanded(child: FlightInfoPanel(game: game));
              },
            ),
          ],
        ),
      ),
    );
  }
}
