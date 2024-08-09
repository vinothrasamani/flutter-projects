import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton(this.ans, this.nextQustion, {super.key});
  final String ans;
  final void Function(String item) nextQustion;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: ElevatedButton(
        onPressed: () {
          nextQustion(ans);
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          foregroundColor: const Color.fromARGB(255, 169, 218, 220),
          backgroundColor: const Color.fromARGB(255, 84, 3, 116),
        ),
        child: Text(
          ans,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
