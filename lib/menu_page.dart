import 'package:flutter/material.dart';
import 'game/game_page.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Touch Dispatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Go to the game screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamePage()),
                );
              },
              child: Text('Start Game'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to settings screen (to be implemented)
              },
              child: Text('Settings'),
            ),
            ElevatedButton(
              onPressed: () {
                // Exit the app
                Navigator.pop(context);
              },
              child: Text('Exit'),
            ),
          ],
        ),
      ),
    );
  }
}