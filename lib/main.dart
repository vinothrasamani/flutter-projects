import 'package:flutter/material.dart';
import 'package:progress_tracker/view/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Color color = const Color.fromARGB(255, 0, 81, 70);

    return MaterialApp(
      title: 'VSD Progress Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: color,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: color,
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      home: const Home(),
    );
  }
}
