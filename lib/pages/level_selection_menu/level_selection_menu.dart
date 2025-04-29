import 'package:flutter/material.dart';
import '../game/game_page.dart';

class LevelData {
  final String name;
  final String description;
  final double spawnRate;
  final String difficulty;
  final Color difficultyColor;

  LevelData({
    required this.name,
    required this.description,
    required this.spawnRate,
    required this.difficulty,
    required this.difficultyColor,
  });
}

class LevelSelectionMenu extends StatefulWidget {
  @override
  _LevelSelectionMenuState createState() => _LevelSelectionMenuState();
}

class _LevelSelectionMenuState extends State<LevelSelectionMenu> {
  final List<LevelData> levels = [
    LevelData(
      name: 'Training',
      description: 'Learn the basics with slow plane spawns',
      spawnRate: 15.0,
      difficulty: 'Easy',
      difficultyColor: Colors.green,
    ),
    LevelData(
      name: 'Regular Shift',
      description: 'Handle regular air traffic',
      spawnRate: 10.0,
      difficulty: 'Medium',
      difficultyColor: Colors.orange,
    ),
    LevelData(
      name: 'Rush Hour',
      description: 'Manage intense air traffic',
      spawnRate: 5.0,
      difficulty: 'Hard',
      difficultyColor: Colors.red,
    ),
  ];

  double _customSpawnRate = 10.0; // Default value for custom level spawn rate

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Level'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: levels.length + 1, // +1 for the custom level
        itemBuilder: (context, index) {
          if (index < levels.length) {
            final level = levels[index];
            return _buildLevelCard(context, level);
          } else {
            return _buildCustomLevelCard(context);
          }
        },
      ),
    );
  }

  // Build a predefined level card
  Widget _buildLevelCard(BuildContext context, LevelData level) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GamePage(spawnRate: level.spawnRate),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                level.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                level.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 8),
              Chip(
                label: Text(
                  level.difficulty,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: level.difficultyColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build the custom level card with slider
  Widget _buildCustomLevelCard(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Custom Level',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Set your own spawn rate',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 8),
            Slider(
              value: _customSpawnRate,
              min: 0.1,
              max: 20.0,
              divisions: 100,
              label: _customSpawnRate.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _customSpawnRate = value;
                });
              },
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GamePage(spawnRate: _customSpawnRate),
                  ),
                );
              },
              child: Text('Start Custom Level'),
            ),
          ],
        ),
      ),
    );
  }
}
