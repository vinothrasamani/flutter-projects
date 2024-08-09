import 'package:flutter/material.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(context) {
    return SizedBox(
      height: 550,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  margin: const EdgeInsets.only(right: 10, top: 5),
                  alignment: Alignment.center,
                  height: 35,
                  width: 35,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: item['user_answer'] == item['correct_answer']
                        ? const Color.fromARGB(255, 103, 255, 118)
                        : const Color.fromARGB(255, 247, 125, 125),
                  ),
                  child: Text(
                    ((item['question_index'] as int) + 1).toString(),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['question'] as String,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Selected Answer : ${item['user_answer'] as String}",
                        style: const TextStyle(
                            color: Color.fromARGB(252, 42, 205, 227),
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Correct Answer : ${item['correct_answer'] as String}",
                        style:
                            const TextStyle(color: Colors.green, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ]),
            );
          }).toList(),
        ),
      ),
    );
  }
}
