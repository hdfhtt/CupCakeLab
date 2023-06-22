import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'screens/view_recipe.dart';

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

const String apiKey = 'c65fcf39f282417ea467298705e9c52d';

/* Make sure to add the following permission in AndroidManifest.xml
 * <!-- Required to fetch data from the internet. -->
 * <uses-permission android:name="android.permission.INTERNET" />
 */

Future<List<Recipe>> fetchRecipe(String query) async {
  final queryParameters = {
    'apiKey': apiKey,
    'query': query,
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
    throw Exception('Error ${response.statusCode}');
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
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ViewRecipeScreen(
              id: id,
              title: title,
              image: image,
            )
        ));
      },
      child: Ink(
        child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme
                    .of(context)
                    .colorScheme
                    .outline,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: ListTile(
              title: Image.network(image,
                  fit: BoxFit.fitWidth,
                  height: 200,
                  width: 400
              ),
              subtitle: Text(title),
            )
        ),
      ),
    );
  }
}
