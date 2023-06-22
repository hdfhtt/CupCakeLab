import 'dart:convert';
import 'package:http/http.dart' as http;

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
