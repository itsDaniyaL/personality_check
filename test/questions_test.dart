import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:personality_checker/state/app_state.dart';

import 'mockito.dart';

void main() {
  group('Questions Logic Tests', () {
    late AppState appState;

    setUp(() {
      appState = AppState();
    });

    test('Selecting answers updates questions correctly', () {
      appState.selectAnswer(0); // Select introvert answer for question 1
      expect(appState.questions[0].selectedOption, 0);

      appState.selectAnswer(1); // Select extrovert answer for question 2
      expect(appState.questions[1].selectedOption, 1);
    });

    test('Finalizing personality type calculates correctly', () {
      appState.selectAnswer(0); // Introvert for question 1
      appState.selectAnswer(1); // Extrovert for question 2

      appState.finalizePersonality();

      // Since introvertCount == extrovertCount, it should return 'ambivert'
      expect(appState.personalityType, 'ambivert');
    });
  });
}
