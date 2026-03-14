import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const GearCheckApp());
}

class GearCheckApp extends StatelessWidget {
  const GearCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GearCheck',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1C1C1E),
        colorScheme: const ColorScheme.dark(
          primary: Colors.amber,
          surface: Color(0xFF2C2C2E),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
