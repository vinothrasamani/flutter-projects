import 'package:favorite_places/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

Color back = const Color.fromARGB(255, 8, 87, 80);

final border = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5),
  borderSide: BorderSide(color: back),
);

final errBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5),
  borderSide: const BorderSide(
    color: Color.fromARGB(255, 224, 0, 0),
  ),
);

final myTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: back,
    brightness: Brightness.dark,
  ),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromARGB(255, 23, 26, 26),
  useMaterial3: true,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleSmall: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: back,
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: border,
    focusedBorder: border,
    focusedErrorBorder: errBorder,
    errorBorder: errBorder,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: back,
      foregroundColor: Colors.white,
    ),
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
      title: 'Awesome Places',
      theme: myTheme,
      home: const HomeScreen(),
    );
  }
}
