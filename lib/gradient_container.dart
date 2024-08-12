import 'package:flutter/material.dart';
import 'package:first_app/dice_roller.dart';

const startAlign = Alignment.topRight;

class GradientContainer extends StatelessWidget {
  const GradientContainer(this.color, {super.key});
  const GradientContainer.forColor({super.key})
      : color = const [
          Color.fromARGB(212, 8, 172, 57),
          Color.fromARGB(199, 193, 16, 16)
        ];

  final List<Color> color;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // colors: [
          //   Color.fromARGB(255, 86, 5, 89),
          //   Color.fromARGB(255, 104, 1, 70)
          // ],
          colors: color,
          begin: startAlign,
          end: Alignment.bottomLeft,
        ),
      ),
      child: const Center(
        // child: StyledText("Hi there.. I'm Vinoth.A"),
        child: DiceRoller(),
      ),
    );
  }
}
