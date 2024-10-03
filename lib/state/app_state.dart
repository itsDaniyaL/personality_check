import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:personality_checker/models/question.dart';
import 'package:personality_checker/utils/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Question> _questions = [];
  String _personalityType = '';
  String _personalityDescription = '';
  bool _isLoading = false;
  int _currentQuestionIndex = 0;

  List<Question> get questions => _questions;
  String get personalityType => _personalityType;
  int get currentQuestionIndex => _currentQuestionIndex;
  Question get currentQuestion => _questions[_currentQuestionIndex];
  String get personalityDescription => _personalityDescription;
  bool get isLoading => _isLoading;

  // Select an answer for the current question
  void selectAnswer(int index) {
    _questions[_currentQuestionIndex].selectedOption = index;
    notifyListeners();
    _saveQuestionsToPreferences(); // Save updated list to SharedPreferences
  }

  // Save the questions list in SharedPreferences
  Future<void> _saveQuestionsToPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> questionsJson =
          _questions.map((q) => jsonEncode(q.toJson())).toList();
      await prefs.setStringList('questions', questionsJson);
    } catch (e) {
      debugPrint('Error saving questions to SharedPreferences: $e');
    }
  }

  // Load questions from SharedPreferences
  Future<void> loadQuestionsFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? questionsJson = prefs.getStringList('questions');

    if (questionsJson != null && questionsJson.isNotEmpty) {
      _questions =
          questionsJson.map((q) => Question.fromJson(jsonDecode(q))).toList();
    } else {
      // Fetch from API if not found in SharedPreferences
      _questions = await _apiService.fetchQuestions();
      await _saveQuestionsToPreferences(); // Save fetched questions for future use
    }
    notifyListeners();
  }

  // Check if the current question has an answer selected
  bool checkSelected() {
    return _questions[currentQuestionIndex].selectedOption == null;
  }

  // Navigate to the next question
  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  // Navigate to the previous question
  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  // Reset the quiz
  void reset() {
    _currentQuestionIndex = 0;
    for (var question in _questions) {
      question.selectedOption = -1;
    }
    notifyListeners();
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

  // Finalize personality based on selected options
  Future finalizePersonality() async {
    _personalityType = await _apiService.finalizePersonality(_questions);
    await getPersonalityDescription();

    notifyListeners();
  }

  // Get personality description
  Future<void> getPersonalityDescription() async {
    _isLoading = true;
    notifyListeners();
    _personalityDescription =
        await _apiService.fetchDescription(_personalityType);
    _isLoading = false;
    notifyListeners();
  }

  // Get progress for progress indicator
  double get progress {
    int answeredQuestions =
        _questions.where((q) => q.selectedOption != null).length;
    return answeredQuestions / _questions.length;
  }

  // Clear questions and reset SharedPreferences
  Future<void> clearQuestions() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      _questions = [];
      _personalityType = '';
      _currentQuestionIndex = 0;
      notifyListeners();
    } catch (e) {
      debugPrint('Error clearing SharedPreferences: $e');
    }
  }

  // Check if this is the last question
  bool get isLastQuestion => _currentQuestionIndex == _questions.length - 1;
}
