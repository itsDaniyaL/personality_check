import 'package:flutter/material.dart';
import 'package:personality_checker/screens/getting_started.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // FirebaseFirestore.instance.settings =
  //     const Settings(persistenceEnabled: true);
  runApp(const MyApp());
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
              title: 'TaskiT',
              theme: ThemeData(
                scaffoldBackgroundColor: const Color(0xFFF2EFE8),
                primaryColorLight: const Color(0xFF76ABAE),
                secondaryHeaderColor: const Color(0xFF31363F),
                primaryColor: const Color(0xFF31363F),
                useMaterial3: true,
                colorScheme:
                    ColorScheme.fromSeed(seedColor: const Color(0xFFEEEEEE))
                        .copyWith(error: const Color(0xFFAE0909))
                        .copyWith(surface: const Color(0xFF222831)),
                fontFamily: 'OpenSans',
              ),
              darkTheme: ThemeData(
                useMaterial3: true,
                scaffoldBackgroundColor: const Color(0xFF222831),
                primaryColorLight: const Color(0xFF76ABAE),
                secondaryHeaderColor: const Color(0xFF212121),
                primaryColor: const Color(0xFFFFFFFF),
                colorScheme:
                    ColorScheme.fromSeed(seedColor: const Color(0xFFEEEEEE))
                        .copyWith(error: const Color(0xFFAE0909))
                        .copyWith(surface: const Color(0xFFEEEEEE)),
                fontFamily: 'OpenSans',
              ),
              themeMode: ThemeMode.light,
              home: const GettingStartedPage());
        });
  }
}
