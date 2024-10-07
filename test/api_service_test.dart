import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:personality_checker/utils/api_service.dart';
import 'package:personality_checker/state/app_state.dart';

import 'mockito.dart';

void main() {
  group('API Service Tests', () {
    late AppState appState;
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
      appState = AppState();
    });

    test('Fetch personality description from API', () async {
      when(mockApiService.fetchDescription('introvert'))
          .thenAnswer((_) async => 'Introvert Description');

      appState.getPersonalityDescription();
      expect(appState.personalityDescription, 'Introvert Description');
    });
  });
}
