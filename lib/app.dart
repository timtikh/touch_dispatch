import 'package:flutter/material.dart';
import 'pages/start_menu_page/start_menu_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartMenuPage(), // Start with the menu page
    );
  }
}