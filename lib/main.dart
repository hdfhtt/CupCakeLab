import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  runApp(const CupCakeLab());
}

/// It is recommended to use your own Spoonacular API, as there can only be 150
/// points per day in the free account. For more information please refer to
/// https://spoonacular.com/food-api/pricing website.
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
