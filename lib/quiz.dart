import 'package:adv_basics/questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:adv_basics/start_screen.dart';
import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  Widget? activeScreen;

  @override
  void initState() {
    super.initState();
    activeScreen = StartScreen(switchScreen); // Start the quiz by showing the StartScreen
  }

  // Function to switch screen from StartScreen to QuestionsScreen
  void switchScreen() {
    setState(() {
      activeScreen = QuestionsScreen(onSelectAnswer: chooseAnswer);
    });
  }

  // Function to handle answer selection
  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    // If all questions have been answered, show the ResultsScreen
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = ResultsScreen(
          chosenAnswers: selectedAnswers,
          onRestart: restartQuiz, // Pass restartQuiz function to ResultsScreen
        );
      });
    }
  }

  // Function to restart the quiz
  void restartQuiz() {
    setState(() {
      selectedAnswers = []; // Reset selected answers
      activeScreen = StartScreen(switchScreen); // Show the StartScreen again
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: activeScreen, // Display the current active screen
        ),
      ),
    );
  }
}
