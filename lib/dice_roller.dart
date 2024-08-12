import 'package:flutter/material.dart';
import 'dart:math';

final randamizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var activeDice = 4;

  void rollDice() {
    setState(() {
      activeDice = randamizer.nextInt(6) + 1;
    });
  }

  @override
  Widget build(contect) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/face$activeDice.png',
          width: 150,
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(244, 193, 193, 3),
              textStyle: const TextStyle(fontSize: 20),
              padding: const EdgeInsets.only(left: 20, right: 20),
              backgroundColor: const Color.fromARGB(211, 189, 29, 207)),
          child: const Text('Roll a Dice'),
        ),
      ],
    );
  }
}
