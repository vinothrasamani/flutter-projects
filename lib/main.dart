import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/shopping_list_home.dart';

void main() {
  runApp(const MyApp());
}

Color light = const Color.fromARGB(255, 82, 2, 129);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: light,
          brightness: Brightness.dark,
          surface: const Color.fromARGB(255, 51, 42, 59),
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: light,
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 55, 50, 60),
      ),
      home: const ShoppingListHome(),
    );
  }
}
