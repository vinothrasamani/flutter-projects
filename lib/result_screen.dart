import 'package:flutter/material.dart';
import 'package:second_app/data/question_list.dart';
import 'package:second_app/question_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(this.choosenAnswers, this.restartQuiz, {super.key});

  final List<String> choosenAnswers;
  final void Function() restartQuiz;

// ---------------------importent concept..------------------
  List<Map<String, Object>> getSummary() {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < choosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].ans[0],
          'user_answer': choosenAnswers[i],
        },
      );
    }
    return summary;
  }
  //-----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final summaryDatas = getSummary();
    final numTotalQustions = questions.length;
    final currectAnswers = summaryDatas
        .where((test) => test['correct_answer'] == test['user_answer'])
        .length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You are correctly answered $currectAnswers questions out of $numTotalQustions",
              style: const TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 220, 203, 18),
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionSummary(summaryDatas),
            const SizedBox(
              height: 40,
            ),
            OutlinedButton.icon(
              onPressed: restartQuiz,
              icon: const Icon(Icons.replay_outlined),
              label: const Text(
                "Restart Quiz",
                style: TextStyle(
                    color: Color.fromARGB(255, 46, 193, 183), fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
