import 'package:flutter/material.dart';
import 'package:personality_checker/models/question.dart';
import 'package:personality_checker/utils/questions_utils.dart';

class AppState extends ChangeNotifier {
  List<Question> _questions = [];
  String _personalityType = '';

  AppState() {
    _questions = QuestionsUtils.questions;
  }

  int _currentQuestionIndex = 0;

  List<Question> get questions => _questions;

  String get personalityType => _personalityType;

  int get currentQuestionIndex => _currentQuestionIndex;

  Question get currentQuestion => _questions[_currentQuestionIndex];

  // Select an answer for the current question
  void selectAnswer(int index) {
    _questions[_currentQuestionIndex].selectedOption = index;
    notifyListeners();
  }

  bool checkSelected() {
    return _questions[currentQuestionIndex].selectedOption == null;
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

  String displayDescription() {
    if (personalityType == "introvert") {
      return QuestionsUtils.introvertDescription;
    } else if (personalityType == "extrovert") {
      return QuestionsUtils.introvertDescription;
    } else {
      return QuestionsUtils.ambivertDescription;
    }
  }

  String personalityImage() {
    if (personalityType == "introvert") {
      return "introvert_illustration";
    } else if (personalityType == "extrovert") {
      return "extrovert_illustration";
    } else {
      return "ambivert_illustration";
    }
  }

  void finalizePersonality() {
    int introvertCount = 0;
    int extrovertCount = 0;

    for (var question in _questions) {
      if (question.selectedOption != null) {
        final selectedOptionKey =
            question.options.keys.toList()[question.selectedOption!];
        final selectedOptionValue = question.options[selectedOptionKey];

        if (selectedOptionValue == 'introvert') {
          introvertCount++;
        } else if (selectedOptionValue == 'extrovert') {
          extrovertCount++;
        }
      }
    }

    if (introvertCount > extrovertCount) {
      _personalityType = 'introvert';
    } else if (extrovertCount > introvertCount) {
      _personalityType = 'extrovert';
    } else {
      _personalityType = 'ambivert';
    }

    notifyListeners();
  }

  // Check if this is the last question
  bool get isLastQuestion => _currentQuestionIndex == _questions.length - 1;

  // Return the progess to show for progress indicator
  double get progress {
    int answeredQuestions =
        _questions.where((q) => q.selectedOption != null).length;
    return answeredQuestions / _questions.length;
  }
}
