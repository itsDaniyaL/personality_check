import 'package:flutter_test/flutter_test.dart';
import 'package:personality_checker/models/question.dart';
import 'package:personality_checker/utils/api_service.dart';

void main() {
  group('API Service Tests', () {
    late ApiService apiService = ApiService();

    test('Fetch personality description from API', () async {
      // Arrange
      List<Question> dummyQuestions = [
        Question(
          title: 'Test question 1',
          options: {'Introvert': 'introvert', 'Extrovert': 'extrovert'},
          selectedOption: 0,
        ),
        Question(
          title: 'Test question 2',
          options: {'Introvert': 'introvert', 'Extrovert': 'extrovert'},
          selectedOption: 1,
        ),
      ];

      // Act
      var personality = await apiService.finalizePersonality(dummyQuestions);

      // Assert
      expect(personality, 'ambivert');
    });

    test('Fetch personality description from API', () async {
      // Act
      var description = await apiService.fetchDescription('ambivert');

      // Assert
      expect(description,
          "You possess a balance of both introverted and extroverted traits. You are adaptable and can thrive in a variety of social situations, whether it involves solitude or interaction with others. Depending on the context, you may enjoy the company of others and seek out social engagement, while at other times, you value your personal space and need moments of quiet reflection. Ambiverts are comfortable navigating between the two extremes of social behaviour, finding energy from both solitude and interaction. Your versatility allows you to strike a balance, making you both approachable and introspective."); // Adjust based on your actual description
    });

    test('Fetch total number of questions from API', () async {
      // Act
      var totalQuestions = await apiService.fetchTotalQuestions();

      // Assert
      expect(totalQuestions, 10); // Should return 2 since we added 2 questions
    });
  });
}
