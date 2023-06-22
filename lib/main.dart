import 'package:flutter/material.dart';
import './recipe.dart';
import './recipe_card.dart';

void main() {
  runApp(const CupCakeLab());
}

late Future<List<Recipe>> futurePopularRecipe;

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
  final List<Widget> _fragments = [
    const PopularFragment(),
    const OtherFragment(),
    const FavoritesFragment()
  ];

  int _selectedTabIndex = 0;
  Widget _currentFragment = const PopularFragment();

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
      _currentFragment = index < _fragments.length ? _fragments[index] : const PopularFragment();
    });
  }

  @override
  void initState() {
    super.initState();
    futurePopularRecipe = fetchRecipe('cupcake');
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
                leading: const Icon(Icons.menu_outlined),
                hintText: 'Search...',
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 16.0)
                ),
                trailing: const [
                  Icon(Icons.search_outlined),
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
            label: 'Popular',
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

class PopularFragment extends StatelessWidget {
  const PopularFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
      future: futurePopularRecipe,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const SizedBox(height: 82.0);
              } else {
                final recipe = snapshot.data![index - 1];

                return RecipeCard(name: recipe.title, description: '');
              }
            }
          );
        } else {
          return const Center(child: Text('No recipe found.'));
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