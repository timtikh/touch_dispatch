import 'package:flutter/material.dart';
import 'package:touch_dispatch/pages/game/game_logic/touch_dispatch_game.dart';

class GameOverOverlay extends StatelessWidget {
  final TouchDispatchGame game;

  const GameOverOverlay({required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 312,
      height: 900,
      color: Colors.black87.withOpacity(0.85),
      child: Center(
        child: IntrinsicWidth(
          stepWidth: 20, // Minimum width but flexible
          child: Card(
            color: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'GAME OVER',
                    style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Mid-air collision occurred!',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  _buildButton(
                    text: 'Restart',
                    icon: Icons.restart_alt,
                    color: Colors.green,
                    onPressed: () {
                      Navigator.pop(context);
                      game.resumeGame();
                      game.overlays.remove('GameOver');
                      game.overlays.remove('PauseMenu');
                      game.restart();
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildButton(
                    text: 'Main Menu',
                    icon: Icons.home,
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    Color color = Colors.blue,
  }) {
    return SizedBox(
      width: 140,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          textStyle: const TextStyle(fontSize: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
