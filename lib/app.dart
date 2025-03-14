import 'package:flutter/material.dart';
import 'menu_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuScreen(), // Start with the menu screen
    );
  }
}