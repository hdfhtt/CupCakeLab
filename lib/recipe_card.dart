import 'package:flutter/material.dart';
import 'screens/view_recipe.dart';

// TODO: Finalize RecipeCard widget.
class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.name, required this.description});

  final String name;
  final String description;

  // final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => const ViewRecipeScreen()
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
              title: Image.asset('assets/vanilla.jpeg',
                  fit: BoxFit.fitWidth,
                  height: 200,
                  width: 400
              ),
              subtitle: Text('\n$name\n$description'),
            )
        ),
      ),
    );
  }
}
