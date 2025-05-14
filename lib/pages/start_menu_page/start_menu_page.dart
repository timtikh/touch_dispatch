import 'package:flutter/material.dart';
import 'package:touch_dispatch/pages/level_selection_menu/level_selection_menu.dart';

import 'dynamic_backround/dynamic_background.dart'; // adjust if needed

class StartMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DynamicBackground(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
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
        ],
      ),
    );
  }
}
