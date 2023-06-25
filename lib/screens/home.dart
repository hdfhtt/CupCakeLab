import 'package:flutter/material.dart';
import '../recipe.dart';

// A future list to be fetch for the BrowseFragment().
late Future<List<Recipe>> futureBrowseRecipe;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// HomeScreen is a stateful widget which contains three switchable fragments
/// that later can be change accordingly to the users action.
class _HomeScreenState extends State<HomeScreen> {
  // List of available fragments in HomeScreen.
  final List<Widget> _fragments = [
    const PopularFragment(),
    const BrowseFragment(),
    const FavoritesFragment()
  ];

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // Set PopularFragment as the initial fragment in HomeScreen.
  int _selectedTabIndex = 0;
  Widget _currentFragment = const PopularFragment();

  // Change fragment function when the tab is selected by the user.
  void _onDestinationSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
      _currentFragment = index < _fragments.length ? _fragments[index] : const BrowseFragment();
    });
  }

  /// Search function when the button is pressed. Take text from the search
  /// controller as the passing argument. Only occurs when searchbar is not
  /// empty.
  void _onSearchButtonPressed() {
    if (_searchController.text.isNotEmpty) {
      setState(() {
        /// Keyword cupcake is predefined in order to avoid fetching any other
        /// unrelated recipes.
        futureBrowseRecipe = fetchRecipe('${_searchController.text} cupcake');

        // Reset search controller and the focus node.
        _searchController.clearComposing();
        _searchController.clear();
        _searchFocusNode.unfocus();

        // Set fragment to BrowseFragment.
        _selectedTabIndex = 1;
        _currentFragment = const BrowseFragment();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Fetch recipes for Browse fragment when HomeScreen is initiated.
    futureBrowseRecipe = fetchRecipe('cupcake');
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Stack layout is used to place the SearchBar on top and overlapping the
      /// the fragment.
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 80.0),
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _currentFragment,
          ),

          // SafeArea is to preserved SearchBar position.
          SafeArea(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              child: SearchBar(
                onTap: () {
                  _searchFocusNode.requestFocus();
                },
                controller: _searchController,
                focusNode: _searchFocusNode,
                backgroundColor: MaterialStateColor.resolveWith(
                  (states) => Theme.of(context).colorScheme.background
                ),
                shadowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent
                ),
                leading: IconButton(
                  onPressed: () { } ,
                  icon: const Icon(Icons.menu_outlined),
                ),
                hintText: 'Search...',
                trailing: [
                  IconButton(
                    onPressed: _onSearchButtonPressed,
                    icon: const Icon(Icons.search_outlined),
                  ),
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
            icon: Icon(Icons.insights_outlined),
            label: 'Popular',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            label: 'Browse',
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

class BrowseFragment extends StatelessWidget {
  const BrowseFragment({super.key});

  @override
  Widget build(BuildContext context) {
    // FutureBuilder is used to create widget from the future list.
    return FutureBuilder<List<Recipe>>(
      future: futureBrowseRecipe,
      builder: (context, snapshot) {
        // Show CircularProgressIndicator() while loading data.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());

        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));

        } else if (snapshot.hasData) {

          /// If the list is successfully fetched but no data found, show this
          /// instead.
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No recipe found.'));

          } else {
            /// ListView.builder will generate a list of RecipeCard() from the
            /// data fetched by the future.
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final recipe = snapshot.data![index];

                return RecipeCard(id: recipe.id, title: recipe.title, image: recipe.image);
              },
            );
          }
        } else {
          throw Exception();
        }
      },
    );
  }
}

class FavoritesFragment extends StatelessWidget {
  const FavoritesFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('All your saved recipe will be appear here.'));
  }
}

class PopularFragment extends StatelessWidget {
  const PopularFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: prefetchRecipes.length,
        itemBuilder: (context, index) {
          return RecipeCard(
            id: prefetchRecipes[index]['id'],
            title: prefetchRecipes[index]['title'],
            image: prefetchRecipes[index]['image'],
            summary: prefetchRecipes[index]['summary'],
          );
        },
      ),
    );
  }
}