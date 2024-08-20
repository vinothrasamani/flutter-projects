import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vsd_chat/view/home_screen.dart';
import 'package:vsd_chat/view/splash_screen.dart';
import 'firebase_options.dart';
import 'package:vsd_chat/view/auth_screen.dart';

Color basicColor = const Color.fromARGB(255, 0, 94, 25);

final border = OutlineInputBorder(
  borderSide: BorderSide(
    color: basicColor,
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VSD Chat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: basicColor,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 27, 27, 27),
        appBarTheme: AppBarTheme(
          backgroundColor: basicColor,
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: border,
          enabledBorder: border,
          errorBorder: border,
          focusedErrorBorder: border,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: basicColor,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return const AuthScreen();
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),
    );
  }
}
