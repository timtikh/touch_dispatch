import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.info_outline, color: Colors.blue),
      tooltip: 'Game Info',
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('How to Play'),
            content: const Text(
              'Guide aircraft to land safely by assigning waypoints and altitudes:\n\n'
                  '• Drag planes to vector them toward waypoints.\n'
                  '• Set target altitude using the "+" and "-" buttons.\n'
                  '• Aircraft must be at 300 ft or below to land on the runway.\n'
                  '• Avoid conflicts between planes to keep the airspace safe!',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}
