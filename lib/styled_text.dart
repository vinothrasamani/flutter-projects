import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.txt, {super.key});

  final String txt;

  @override
  Widget build(context) {
    return Text(
      txt,
      style: const TextStyle(
        color: Color.fromARGB(255, 38, 255, 0),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
