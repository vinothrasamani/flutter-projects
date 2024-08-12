import 'package:flutter/material.dart';
import 'package:first_app/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        // backgroundColor: Color.fromARGB(255, 119, 0, 123),
        body: GradientContainer(
          [Color.fromARGB(255, 81, 8, 97), Color.fromARGB(255, 104, 1, 70)],
        ),
        // body: GradientContainer.forColor(),
      ),
    ),
  );
}
