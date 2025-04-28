import 'package:flutter/material.dart';
import 'package:touch_dispatch/pages/game/game_logic/touch_dispatch_game.dart';

class PauseMenuOverlay extends StatelessWidget {
  final TouchDispatchGame game;

  const PauseMenuOverlay({required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Card(
          color: Colors.black87,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'PAUSE',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                _buildButton(
                  'Resume',
                  Icons.play_arrow,
                      () {
                    game.resumeGame();
                  },
                ),
                SizedBox(height: 10),
                _buildButton(
                  'Main Menu',
                  Icons.home,
                      () {
                    game.pauseEngine();
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
                SizedBox(height: 10),
                _buildButton(
                  'Exit Game',
                  Icons.exit_to_app,
                      () => Navigator.of(context).popUntil((route) => !route.hasActiveRouteBelow),
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, IconData icon, VoidCallback onPressed, {Color color = Colors.blue}) {
    return SizedBox(
      width: 200,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}