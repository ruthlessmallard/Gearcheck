import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const PpeReminderApp());
}

class PpeReminderApp extends StatelessWidget {
  const PpeReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PPE Reminder',
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
      home: const HomeScreen(),
    );
  }
}
