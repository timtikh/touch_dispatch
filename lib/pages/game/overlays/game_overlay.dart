import 'package:flutter/material.dart';
import 'package:touch_dispatch/pages/game/overlays/pause_overlay.dart';
import 'package:touch_dispatch/pages/game/game_logic/touch_dispatch_game.dart';

class GameOverlay extends StatefulWidget {
  final TouchDispatchGame game;

  const GameOverlay({required this.game});

  @override
  _GameOverlayState createState() => _GameOverlayState();
}
class _GameOverlayState extends State<GameOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Game info panel TODO: ADD PROPER STATEMANAGER
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Flights Info',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: widget.game.getFlightInfoWidgets(),
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
            child: ElevatedButton(
              onPressed: () {
                if (widget.game.isPaused) {
                  widget.game.resumeGame();
                } else {
                  widget.game.pauseGame();
                }
                setState(() {});
              },
              child: Icon(widget.game.isPaused ? Icons.play_arrow : Icons.pause),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.all(20),
              ),
            ),
          ),
        ),
        // Pause menu overlay
        if (widget.game.isPaused) PauseMenuOverlay(game: widget.game),
      ],
    );
  }
}