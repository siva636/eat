import 'package:eat/src/onboarding/onboarding.dart';
import 'package:eat/src/onboarding/splash.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.red,
        fontFamily: 'ultra',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
          ),
        ),
      ),
      home: const Splash(),
    );
  }
}
