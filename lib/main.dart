import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_store/view/authentication.dart';

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
    Color color = const Color.fromARGB(255, 0, 107, 101);

    InputDecorationTheme inputTheme = const InputDecorationTheme(
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      labelStyle: TextStyle(
        color: Colors.white,
      ),
    );

    AppBarTheme appBar = AppBarTheme(
      backgroundColor: color,
      foregroundColor: Colors.white,
    );

    return MaterialApp(
      title: 'Mobile Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: color,
        ),
        useMaterial3: true,
        inputDecorationTheme: inputTheme,
        appBarTheme: appBar,
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: color,
        ),
        inputDecorationTheme: inputTheme,
        appBarTheme: appBar,
      ),
      home: const Authentication(),
    );
  }
}
