import 'package:flutter/material.dart';
import 'package:second_app/answer_button.dart';
import 'package:second_app/data/question_list.dart';

class Questions extends StatefulWidget {
  const Questions({super.key, required this.onChoosedAnswer});
  final void Function(String ans) onChoosedAnswer;

  @override
  State<Questions> createState() {
    return _QustionsState();
  }
}

class _QustionsState extends State<Questions> {
  var currentQuestionIndex = 0;

  void updateNextIndex(String selected) {
    widget.onChoosedAnswer(selected);
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Qustion : ${currentQuestion.num}",
              style: const TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 232, 213, 87),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              currentQuestion.text,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            ...currentQuestion.getSuffledList().map((answer) {
              return AnswerButton(
                answer,
                updateNextIndex,
              );
            }),
          ],
        ),
      ),
    );
  }
}
