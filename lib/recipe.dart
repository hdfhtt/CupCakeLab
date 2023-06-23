import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'screens/view_recipe.dart';

import './main.dart';

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

/* Make sure to add the following permission in AndroidManifest.xml
 * <!-- Required to fetch data from the internet. -->
 * <uses-permission android:name="android.permission.INTERNET" />
 */

Future<List<Recipe>> fetchRecipe(String query) async {
  final queryParameters = {
    'apiKey': apiKey,
    'query': query,
    'sort': 'random',
  };

  final uri = Uri.https('api.spoonacular.com', '/recipes/complexSearch', queryParameters);
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    List<Recipe> recipes = [];

    Map<String, dynamic> data = jsonDecode(response.body);

    List<dynamic> results = data['results'];

    for (var result in results) {
      Recipe recipe = Recipe.fromJson(result);
      recipes.add(recipe);
    }

    return recipes;
  } else {
    throw Exception(response.statusCode);
  }
}

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

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.id,
    required this.title,
    required this.image,
  });

  final int id;
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      // color: Theme.of(context).colorScheme.surfaceVariant,
      elevation: 1.0,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: () {
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
            ),

            Container(
              padding: const EdgeInsets.all(16.0),
              height: 80.0,
              width: double.infinity,
              child: Text(title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.left,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}