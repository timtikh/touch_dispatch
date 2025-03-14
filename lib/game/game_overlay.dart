import 'package:flutter/material.dart';
import 'package:touch_dispatch/game/touch_dispatch_game.dart';


class GameOverlay extends StatefulWidget {
  final TouchDispatchGame game;

  const GameOverlay({required this.game});

  @override
  _GameOverlayState createState() => _GameOverlayState();
}

class _GameOverlayState extends State<GameOverlay> {
  @override
  void initState() {
    super.initState();

    // Listen for changes in the planesNotifier to trigger updates in the overlay
    widget.game.planesNotifier.addListener(_onPlanesChanged);
  }

  @override
  void dispose() {
    // Remove listener when the widget is disposed
    widget.game.planesNotifier.removeListener(_onPlanesChanged);
    super.dispose();
  }

  void _onPlanesChanged() {
    setState(() {
      // The setState call here ensures the overlay is rebuilt when planes update
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
                setState(() {}); // Rebuild the button to show play/pause icon
              },
              child:
                  Icon(widget.game.isPaused ? Icons.play_arrow : Icons.pause),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(), backgroundColor: Colors.red,
                padding: EdgeInsets.all(20), // Background color
              ),
            ),
          ),
        ),
      ],
    );
  }
}
