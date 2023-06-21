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
  final recipes = List<String>.generate(10, (index) => 'Recipe ${index + 1}');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];

                    if (index == 0) {
                      /* Create first item as padding */
                      return const SizedBox(height: 82.0);
                    } else {
                      return RecipeCard(
                        name: recipe,
                        description: 'Lorem ipsum dolor si amet.'
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          SafeArea(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              child: SearchBar(
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
          ),
        ],
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
