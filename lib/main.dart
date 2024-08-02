import 'package:expense_tracker/expense_tracker_home.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

void main() {
  Color dark = const Color.fromARGB(255, 2, 94, 96);
  Color light = const Color.fromARGB(255, 14, 96, 2);

  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((func) {
  //   runApp(app);
  // });

  runApp(
    MaterialApp(
      // themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: dark,
        ),
        datePickerTheme: DatePickerThemeData(
          headerBackgroundColor: dark,
          headerForegroundColor: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: dark,
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: dark,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: dark,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: dark,
            foregroundColor: Colors.white,
          ),
        ),
        cardTheme: const CardTheme(
          color: Color.fromARGB(52, 34, 236, 202),
          margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: light,
        ),
        datePickerTheme: DatePickerThemeData(
          headerBackgroundColor: light,
          headerForegroundColor: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: light,
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: light,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: light,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: light,
            foregroundColor: Colors.white,
          ),
        ),
        cardTheme: const CardTheme(
          color: Color.fromARGB(52, 61, 236, 34),
          margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
        ),
      ),
      home: const ExpenseTrackerHome(),
    ),
  );
}
