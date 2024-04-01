import 'package:bmi_modern/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
