import 'package:flutter/material.dart';
import 'package:second_app/container_quiz.dart';
import 'package:second_app/questions.dart';
import 'package:second_app/data/question_list.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'l10n/app_localizations.dart';
import 'package:second_app/result_screen.dart';
// import 'package:your_app/l10n/app_localizations.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activePage = "start-screen";

  // @override
  // void initState() {
  //   activePage = ContainerQuiz(changeScreen);
  //   super.initState();
  // }

  void changeScreen() {
    setState(() {
      activePage = "questions-screen";
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activePage = "result-screen";
      });
    }
  }

  void restart() {
    selectedAnswers = [];
    setState(() {
      activePage = "questions-screen";
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenwidget = activePage == "start-screen"
        ? ContainerQuiz(changeScreen)
        : activePage == "questions-screen"
            ? Questions(
                onChoosedAnswer: chooseAnswer,
              )
            : ResultScreen(selectedAnswers, restart);

    return MaterialApp(
      title: 'Quiz Game',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate, // Custom delegate for translations
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('ta', ''), // Spanish
      ],
      locale: const Locale('ta', ''),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 60, 1, 43),
                Color.fromARGB(255, 35, 2, 65)
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: screenwidget,
        ),
      ),
    );
  }
}
