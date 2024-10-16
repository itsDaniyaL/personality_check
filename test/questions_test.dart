import 'package:flutter_test/flutter_test.dart';
import 'package:personality_checker/models/question.dart';
import 'package:personality_checker/state/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Initialize Flutter services
  setUp(() {
    SharedPreferences.setMockInitialValues({}); // Mock SharedPreferences
  });

  group('Questions Logic Tests', () {
    late AppState appState;

    setUp(() {
      appState = AppState();
    });

    test('Selecting answers updates questions correctly', () {
      // Arrange
      // Assume questions are pre-loaded
      List<Question> dummyQuestions = [
        Question(
          title: 'Test question 1',
          options: {'Introvert': 'introvert', 'Extrovert': 'extrovert'},
        ),
      ];

      appState.setQuestions(dummyQuestions);

      // Act
      appState.selectAnswer(0); // Select introvert answer for question 1
      expect(appState.questions[0].selectedOption, 0); // Assert

      appState.selectAnswer(1); // Select extrovert answer for question 2
      expect(appState.questions[0].selectedOption, 1); // Assert
    });

    test('Setting questions updates the questions list', () {
      // Arrange
      // Create dummy questions
      List<Question> dummyQuestions = [
        Question(
          title: 'Question 1',
          options: {'Option A': 'option_a', 'Option B': 'option_b'},
        ),
      ];

      // Act
      appState.setQuestions(dummyQuestions);

      // Assert
      expect(appState.questions.length, 1);
      expect(appState.questions[0].title, 'Question 1');
    });

    test('Selecting an answer updates the selected option', () {
      // Create dummy questions
      //Arrange
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

      // Set questions
      appState.setQuestions(dummyQuestions);

      // Select an answer for the first question
      appState.selectAnswer(0); // Select Option A
      expect(appState.questions[0].selectedOption, 0); // Assert

      // Select an answer for the second question
      appState.selectAnswer(1); // Select Option D
      expect(appState.questions[0].selectedOption, 1); // Assert
    });

    test('Checking selected answer works correctly', () {
      // Arrange
      // Create dummy questions
      List<Question> dummyQuestions = [
        Question(
          title: 'Question 1',
          options: {'Option A': 'option_a', 'Option B': 'option_b'},
        ),
      ];

      // Set questions
      appState.setQuestions(dummyQuestions);

      // Assert that no answer is selected initially
      expect(appState.checkSelected(), true); // No answer selected

      // Select an answer
      appState.selectAnswer(0); // Select Option A

      // Assert that an answer is now selected
      expect(appState.checkSelected(), false); // Answer selected
    });

    test('Resetting questions clears selected options', () {
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

      // Set questions
      appState.setQuestions(dummyQuestions);

      // Select answers
      appState.selectAnswer(0); // Select Option A for Question 1
      appState.selectAnswer(1); // Select Option D for Question 2

      // Reset the quiz
      appState.reset();

      // Assert that all selected options are cleared
      expect(appState.questions[0].selectedOption, -1); // Reset for Question 1
      expect(appState.questions[1].selectedOption, -1); // Reset for Question 2
      expect(appState.currentQuestionIndex,
          0); // Ensure current question index is reset
    });
  });
}
