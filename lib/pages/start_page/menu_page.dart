import 'package:flutter/material.dart';
import 'package:touch_dispatch/pages/level_selection_menu/level_selection_menu.dart';

class MenuPage extends StatelessWidget {
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
                  MaterialPageRoute(builder: (context) => LevelSelectionMenu()),
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
          ],
        ),
      ),
    );
  }
}