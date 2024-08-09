import 'package:flutter/material.dart';
import 'package:note_book/note_book_home.dart';

void main() {
  const dark = Color.fromARGB(255, 23, 10, 119);
  const light = Color.fromARGB(255, 146, 22, 204);
  const textColor = Colors.white;

  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: dark,
          foregroundColor: textColor,
        ),
        cardTheme: const CardTheme(
          color: Color.fromARGB(105, 160, 27, 204),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: dark),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: dark),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: dark, foregroundColor: textColor),
        ),
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.black),
        datePickerTheme: const DatePickerThemeData(
          headerBackgroundColor: dark,
          headerForegroundColor: textColor,
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: light,
        ),
        appBarTheme: const AppBarTheme(
          foregroundColor: textColor,
          backgroundColor: light,
        ),
        cardTheme: const CardTheme(
          color: Color.fromARGB(95, 90, 69, 244),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: light),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: light),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: light.withOpacity(0.5),
            foregroundColor: textColor,
          ),
        ),
        datePickerTheme: const DatePickerThemeData(
          headerBackgroundColor: light,
          headerForegroundColor: textColor,
        ),
      ),
      home: const NoteBookHome(),
    ),
  );
}
