import 'package:flutter/material.dart';
import './view_recipe.dart';

// TODO: Finalize RecipeCard widget.
class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.name, required this.description});

  final String name;
  final String description;
  // final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return(
      InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              // TODO: Pass arguments using ViewRecipeScreen().
              builder: (builder) => const ViewRecipeScreen()
            )
          );
        },
        child: Column(
          children: [
            // Image.network(imageUrl),
            Text(name),
            Text(description),
          ],
        ),
    ));
  }

}