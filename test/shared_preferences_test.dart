import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:personality_checker/models/question.dart';
import 'package:personality_checker/state/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('AppState SharedPreferences Tests', () {
    late AppState appState;

    setUp(() async {
      // Initialize SharedPreferences for each test
      SharedPreferences.setMockInitialValues({});
      SharedPreferences prefs = await SharedPreferences.getInstance();
      appState = AppState(sharedPreferences: prefs);
    });

    tearDown(() async {
      // Clear SharedPreferences after each test
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    });

    test('Saving questions to SharedPreferences via setQuestions', () async {
      // Arrange
      // Create dummy questions
      List<Question> dummyQuestions = [
        Question(
          title: 'Question 1',
          options: {'Option A': 'option_a', 'Option B': 'option_b'},
        ),
        Question(
          title: 'Question 2',
          options: {'Option C': 'option_c', 'Option D': 'option_d'},
        ),
      ];

      // Act
      // Set questions, which will internally call the save method
      appState.setQuestions(dummyQuestions);

      // Verify that questions are saved in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      List<String>? savedQuestionsJson = prefs.getStringList('questions');

      // Assert
      expect(savedQuestionsJson, isNotNull);
      expect(savedQuestionsJson!.length, 2);
      expect(savedQuestionsJson[0],
          contains('Question 1')); // Check for the first question
    });

    test('Loading questions from SharedPreferences', () async {
      // Arrange
      // Create dummy questions
      List<Question> dummyQuestions = [
        Question(
          title: 'Question 1',
          options: {'Option A': 'option_a', 'Option B': 'option_b'},
        ),
      ];

      // Act
      // Save the questions directly to SharedPreferences for loading
      final prefs = await SharedPreferences.getInstance();
      List<String> questionsJson =
          dummyQuestions.map((q) => jsonEncode(q.toJson())).toList();
      await prefs.setStringList('questions', questionsJson);

      // Load questions into AppState
      await appState.loadQuestionsFromPreferences();

      // Assert
      // Assert that questions are loaded correctly
      expect(appState.questions.length, 1);
      expect(appState.questions[0].title, 'Question 1');
    });
  });
}
