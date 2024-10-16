import 'package:flutter/material.dart';
import 'package:personality_checker/screens/getting_started.dart';
import 'package:personality_checker/state/app_state.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppState()),
  ], child: const MyApp()));
}

ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (context, currentMode, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Personality Checker',
              theme: ThemeData(
                scaffoldBackgroundColor: const Color(0xFFF2EFE8),
                primaryColorLight: const Color(0xFF1E1515),
                secondaryHeaderColor: const Color(0xFFFD9191),
                dialogBackgroundColor: const Color(0xFFFFFFFF),
                useMaterial3: true,
                colorScheme:
                    ColorScheme.fromSeed(seedColor: const Color(0xFFEEEEEE))
                        .copyWith(error: const Color(0xFFAE0909))
                        .copyWith(surface: const Color(0xFF222831)),
                fontFamily: 'OpenSans',
              ),
              themeMode: ThemeMode.light,
              home: const GettingStartedPage());
        });
  }
}
