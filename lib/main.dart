import 'package:flutter/material.dart';
import 'package:http_crud_app/mine/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color.fromARGB(255, 114, 0, 63),
        ),
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromARGB(255, 28, 23, 26),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 114, 0, 63),
        ),
      ),
      home: const HomePage(),
    );
  }
}
