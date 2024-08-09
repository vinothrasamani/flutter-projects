import 'package:flutter/material.dart';

class ContainerQuiz extends StatelessWidget {
  const ContainerQuiz(this.screen, {super.key});

  final void Function() screen;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image.asset(
          //   'assets/images/quiz.png',
          //   width: 300,
          //   color: Color.fromARGB(22, 116, 0, 104),
          // ),
          Opacity(
            opacity: 0.8,
            child: Image.asset(
              'assets/images/quiz.png',
              width: 300,
            ),
          ),
          const Text(
            "It's time to take Quiz!",
            style: TextStyle(height: 6, fontSize: 20, color: Colors.white),
          ),
          OutlinedButton.icon(
            onPressed: screen,
            icon: const Icon(
              Icons.arrow_circle_right_outlined,
              size: 28,
            ),
            label: const Text(
              "Start Quiz",
              style: TextStyle(
                color: Color.fromARGB(255, 13, 178, 237),
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
