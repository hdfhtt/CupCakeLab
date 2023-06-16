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
          colorSchemeSeed: Colors.pink,
          useMaterial3: true,
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
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SafeArea(child:
              SearchBar(
                backgroundColor: MaterialStateColor.resolveWith(
                  (states) => Theme.of(context).colorScheme.background
                ),
                shadowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent
                ),
                leading: const Icon(Icons.cookie_outlined),
                hintText: 'Search...',
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 16.0)
                ),
                trailing: const [
                  Icon(Icons.search),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.circle_outlined),
            label: 'Latest',
          ),
          NavigationDestination(
            icon: Icon(Icons.circle_outlined),
            label: 'Other',
          ),
          NavigationDestination(
            icon: Icon(Icons.circle_outlined),
            label: 'Favorite',
          ),
        ]
      )
    );
  }
}
