import 'package:flutter/material.dart';

void main() {
  runApp(const CupCakeLab());
}

class CupCakeLab extends StatelessWidget {
  const CupCakeLab({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CupCakeLab',
      theme: ThemeData(
          useMaterial3: true
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CupCakeLab'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SearchBar(
              hintText: 'Search...',
              leading: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: const Icon(Icons.search),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
