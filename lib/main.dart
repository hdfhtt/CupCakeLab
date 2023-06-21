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
  Widget _currentFragment = LatestFragment();
  int _selectedTabIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedTabIndex = index;

      switch(index) {
        case 1: _currentFragment = const OtherFragment();
          break;
        case 2: _currentFragment = const FavoritesFragment();
          break;
        default: _currentFragment = LatestFragment();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: _currentFragment,
                )
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
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _selectedTabIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            selectedIcon: Icon(Icons.auto_awesome),
            label: 'Latest',
          ),
          NavigationDestination(
            icon: Icon(Icons.cookie_outlined),
            selectedIcon: Icon(Icons.cookie),
            label: 'Other Recipes',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ]
      )
    );
  }
}

class LatestFragment extends StatelessWidget {
  final recipes = List<String>.generate(10, (index) => 'Recipe ${index + 1}');

  LatestFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}

class FavoritesFragment extends StatelessWidget {
  const FavoritesFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('This will show a list of recipes that has been favorite.');
  }
}

class OtherFragment extends StatelessWidget {
  const OtherFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('This will show any other types of recipe beside cupcakes.');
  }
}