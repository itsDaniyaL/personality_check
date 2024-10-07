import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:personality_checker/state/app_state.dart';

import 'mockito.dart';

void main() {
  group('SharedPreferences Tests', () {
    late AppState appState;
    late MockSharedPreferences mockPrefs;

    setUp(() {
      mockPrefs = MockSharedPreferences();
      appState = AppState();
    });

    test('Save and retrieve questions from SharedPreferences', () async {
      // Mock the SharedPreferences interaction
      when(mockPrefs.getStringList('questions')).thenReturn(null);

      await appState.loadQuestionsFromPreferences();

      // Ensure that questions are loaded (mocking an API call or default data)
      expect(appState.questions.isNotEmpty, true);

      // Verify that SharedPreferences setStringList is called
      verify(mockPrefs.getStringList('questions')).called(1);
    });
  });
}
