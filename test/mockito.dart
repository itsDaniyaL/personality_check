import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:personality_checker/utils/api_service.dart';

class MockApiService extends Mock implements ApiService {}

class MockSharedPreferences extends Mock implements SharedPreferences {}
