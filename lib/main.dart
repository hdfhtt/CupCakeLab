import 'package:flutter/material.dart';
import './recipe_card.dart';

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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                leading: const Icon(Icons.menu),
                hintText: 'Search...',
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 16.0)
                ),
                trailing: const [
                  Icon(Icons.search),
                ],
              ),
            ),
            // TODO: Create a list view of RecipeCard widgets.
            const Column(
              children: [
                RecipeCard(
                  name: 'Chocolate Cupcake',
                  description: 'A delicious chocolate cupcake recipe',
                ),
              ],
            )
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
            label: 'Favorites',
          ),
        ]
      )
    );
  }
}
