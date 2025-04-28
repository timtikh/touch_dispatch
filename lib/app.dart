import 'package:flutter/material.dart';
import 'pages/start_page/menu_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuPage(), // Start with the menu page
    );
  }
}