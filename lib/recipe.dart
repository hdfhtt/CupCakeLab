import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'screens/view_recipe.dart';
import './main.dart';

/// This is a prefetched recipes of the top 5 cupcakes recipe all the time to
/// provide better user experience and faster loading time for the home screen.
final List<dynamic> prefetchRecipes = [
  {'id': 618602, 'title': 'Classic Vanilla Cupcake', 'summary': 'A timeless fluffy vanilla cupcakes', 'image': 'https://www.allrecipes.com/thmb/GsldgnTeewAv5eEqoxQ7E1iAKO8=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/157877-vanilla-cupcakes-ddmfs-2X1-0399-1b671dfd598548b1b0339076d062a758.jpg'},
  {'id': 462433, 'title': 'Chocolate Fudge Cupcake', 'summary': 'Rich and indulgent chocolate fudge cupcakes', 'image': 'https://moversandbakers.co.uk/wp-content/uploads/2022/05/Chocolate-Fudge-Cupcakes_0770.jpg'},
  {'id': 658108, 'title': 'Red Velvet Cupcake', 'summary': 'Cocoa-infused, vibrant cupcakes with cream cheese frosting', 'image': 'https://freshaprilflours.com/wp-content/uploads/2017/09/rv-cupcakes-07.jpg'},
  {'id': 1002592, 'title': 'Lemon Blueberry Cupcake', 'summary': 'A refreshing lemon and blueberry cupcakes','image': 'https://bubbapie.com/wp-content/uploads/2020/02/Lemon-Blueberry-Cupcakes.jpg'},
  {'id': 350420, 'title': 'Carrot Cupcake with Cream Cheese Frosting', 'summary': 'A moist spiced carrot cupcakes with tangy cream cheese frosting', 'image': 'https://eatsbythebeach.com/wp-content/uploads/2022/02/Ultimate-Carrot-Cake-Cupcakes-1-Eats-By-The-Beach.jpeg'},
];

/// Represents a recipe object with id, title, and image properties.
class Recipe {
  final int id;
  final String title;
  final String image;

  const Recipe({
    required this.id,
    required this.title,
    required this.image,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      image: json['image'],
    );
  }
}

/// Fetch recipe of the given query using the Spoonacular API. The sort is set
/// to random to give variation of result. Return the list of recipes provided
/// by the Spoonacular API.
Future<List<Recipe>> fetchRecipe(String query) async {
  final queryParameters = {
    'apiKey': apiKey,
    'query': query,
    'sort': 'random',
  };

  final uri = Uri.https('api.spoonacular.com', '/recipes/complexSearch', queryParameters);
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    // Create an empty list of Recipe
    List<Recipe> recipes = [];

    // The fetched data will be decode and store in the new list called results
    Map<String, dynamic> data = jsonDecode(response.body);
    List<dynamic> results = data['results'];

    // Iterate throughout the list and add each recipe to the recipes list.
    for (var result in results) {
      Recipe recipe = Recipe.fromJson(result);
      recipes.add(recipe);
    }

    return recipes;
  } else {
    throw Exception(response.statusCode);
  }
}


/// Fetch recipe ingredients by the given id as the perimeter. Return the list
/// of ingredient for the particular recipe.
Future<List<String>> fetchRecipeIngredients(int id) async {
  final response = await http.get(Uri.parse('https://api.spoonacular.com/recipes/$id/ingredientWidget.json'));

  if (response.statusCode == 200) {
    List<String> ingredients = [];

    Map<String, dynamic> data = jsonDecode(response.body);

    List<dynamic> results = data['ingredients'];

    for (var result in results) {
      ingredients.add(result);
    }

    return ingredients;
  } else {
    throw Exception(response.statusCode);
  }
}

/// This is a custom widget act as card and will be use to display placeholder
/// image, recipe name, and the summary (optional).
class RecipeCard extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  String summary;

  RecipeCard({
    super.key,
    required this.id,
    required this.title,
    required this.image,
    this.summary = '',
  });

  late bool hasSummary = summary.isNotEmpty ? true : false;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 1.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: () {
          // Open the ViewRecipeScreen() when tapped.
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => ViewRecipeScreen(
              id: id,
              title: title,
              image: image,
            )
          ));
        },
        child: Column(
          children: [
            Image.network(image,
              height: 176.0,
              width: double.infinity,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              isAntiAlias: true,
              loadingBuilder: (context, child, loadingProgress) {
                // Show CircularProgressIndicator() when image is loading.
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),

            Container(
              padding: const EdgeInsets.all(16.0),
              height: 80.0,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: hasSummary ? 1 : 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Hide if no summary property is provided.
                  Visibility(
                    visible: hasSummary,
                    child: Text(summary,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
