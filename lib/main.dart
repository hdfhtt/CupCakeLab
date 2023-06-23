import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  runApp(const CupCakeLab());
}

// Spoonacular API Key
const String apiKey = 'c65fcf39f282417ea467298705e9c52d';

class CupCakeLab extends StatelessWidget {
  const CupCakeLab({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CupCakeLab',
      theme: ThemeData(
        colorSchemeSeed: Colors.pink,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
