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
  int _totalQuestions = 0;

  List<Question> get questions => _questions;
  String get personalityType => _personalityType;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get totalQuestions => _totalQuestions;
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
       await prefs.setInt('currentQuestionIndex', _currentQuestionIndex);
    } catch (e) {
      debugPrint('Error saving questions to SharedPreferences: $e');
    }
  }

  // Load questions and total count from SharedPreferences
  Future<void> loadQuestionsFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get questions as List<String>
    List<String>? questionsJson = prefs.getStringList('questions');

    // Get totalQuestions as an int
    int? totalQuestions = prefs.getInt('totalQuestions');
    int? currentQuestionIndex = prefs.getInt('currentQuestionIndex');

    if (totalQuestions != null && currentQuestionIndex != null) {
      _totalQuestions = totalQuestions;
      _currentQuestionIndex = currentQuestionIndex;
    }

    // Load total number of questions from the API if not in SharedPreferences
    if (_totalQuestions == 0) {
      _totalQuestions = await _apiService.fetchTotalQuestions();
      await prefs.setInt('totalQuestions', _totalQuestions);
    }

    if (questionsJson != null && questionsJson.isNotEmpty) {
      _questions = questionsJson.map((q) => Question.fromJson(jsonDecode(q))).toList();
    } else {
      // Fetch the first question from the API if not found in SharedPreferences
      Question fetchedQuestion = await _apiService.fetchQuestion(_currentQuestionIndex);
      _questions.add(fetchedQuestion);
      await _saveQuestionsToPreferences(); // Save fetched question for future use
    }

    notifyListeners();
  }


  // Fetch the next question from API
  Future<void> fetchNextQuestion() async {
    if (_currentQuestionIndex < _totalQuestions - 1) {
      _currentQuestionIndex++;
      Question nextQuestion = await _apiService.fetchQuestion(_currentQuestionIndex);
      _questions.add(nextQuestion);
      await _saveQuestionsToPreferences(); // Save updated questions
      notifyListeners();
    }
  }

  // Check if the current question has an answer selected
  bool checkSelected() {
    return _questions[currentQuestionIndex].selectedOption == null;
  }

  // Navigate to the next question
  void nextQuestion() async {
    if (_currentQuestionIndex < _questions.length) {
      await fetchNextQuestion();
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
    return answeredQuestions / _totalQuestions;
  }

  void clearSelectedOptions() {
    for (var question in _questions) {
      question.selectedOption = null;
    }
  }

  // Clear questions and reset SharedPreferences
  Future<void> clearQuestions() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('questions');
      await preferences.remove('totalQuestions');
      await preferences.remove('currentQuestionIndex');
      clearSelectedOptions();
      _questions = [];
      _personalityType = '';
      _currentQuestionIndex = 0;
      _totalQuestions = 0;
    } catch (e) {
      debugPrint('Error clearing SharedPreferences: $e');
    }
  }

  // Check if this is the last question
  bool get isLastQuestion => _currentQuestionIndex == _totalQuestions - 1;
}
