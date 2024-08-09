import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods/screens/tab_screen.dart';
import 'package:google_fonts/google_fonts.dart';

Color light = const Color.fromARGB(255, 8, 70, 69);
Color textColor = const Color.fromARGB(255, 255, 255, 255);
final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: light,
  ),
  textTheme: GoogleFonts.latoTextTheme(),
  appBarTheme: AppBarTheme(
    backgroundColor: light,
    foregroundColor: textColor,
  ),
);

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Make Foods',
      theme: theme,
      home: const TabScreen(),
    );
  }
}
