import 'package:flutter/material.dart';
import 'package:personality_checker/models/question.dart';

class AppState extends ChangeNotifier {
  final List<Question> _questions = [
    Question(
        title:
            'You’re really busy at work and a colleague is telling you their life story and personal woes.',
        options: [
          'Don’t dare to interrupt them',
          'Think it’s more important to give them some of your time; work can wait',
          'Listen, but with only with half an ear',
          'Interrupt and explain that you are really busy at the moment'
        ]),
    Question(
        title:
            'You’ve been sitting in the doctor’s waiting room for more than 25 minutes.',
        options: [
          'Look at your watch every two minutes',
          'Bubble with inner anger, but keep quiet',
          'Explain to other equally impatient people in the room that the doctor is always running late',
          'Complain in a loud voice, while tapping your foot impatiently'
        ]),
    Question(
        title:
            'You’re having an animated discussion with a colleague regarding a project that you’re in charge of.',
        options: [
          'Don’t dare contradict them',
          'Think that they are obviously right',
          'Defend your own point of view, tooth and nail',
          'Continuously interrupt your colleague'
        ]),
  ];

  int _currentQuestionIndex = 0;

  List<Question> get questions => _questions;

  int get currentQuestionIndex => _currentQuestionIndex;

  Question get currentQuestion => _questions[_currentQuestionIndex];

  // Select an answer for the current question
  void selectAnswer(int index) {
    _questions[_currentQuestionIndex].selectedOption = index;
    notifyListeners();
  }

  // Move to the next question
  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  // Move to the previous question
  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  // Reset the quiz (optional)
  void reset() {
    _currentQuestionIndex = 0;
    for (var question in _questions) {
      question.selectedOption = -1;
    }
    notifyListeners();
  }

  // Check if this is the last question
  bool get isLastQuestion => _currentQuestionIndex == _questions.length - 1;

  // Return the progess to show for progress indicator
  double get progress {
    return _currentQuestionIndex / _questions.length;
  }
}
