import 'package:flutter/material.dart';
import './view_recipe.dart';

// TODO: Finalize RecipeCard widget.
/* class RecipeCard extends StatelessWidget {
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
*/
import 'package:flutter/material.dart';
void main() {
  runApp(const CardExamplesApp());
}

class CardExamplesApp extends StatelessWidget {
  const CardExamplesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('Recipe Card')),
        body: const Column(
          children: <Widget>[
            VanillaCard(),
            MatchaCard(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class VanillaCard extends StatelessWidget {
  const VanillaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: SizedBox(
          width: 400,
          height: 300,
          child: Center(
            child: 
              ListTile(
                title: Image.asset('assets/vanilla.jpeg', fit: BoxFit.fitWidth, height: 200,width: 400 ),
                subtitle: const Text('\nClassic Vanilla Cupcake\nLorem ipsum dolor sit amet.'),
              ),
          ),
        ),
      ),
    );
  }
}

class MatchaCard extends StatelessWidget {
  const MatchaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: SizedBox(
          width: 400,
          height: 300,
          child: Center(
            child: 
              ListTile(
                title: Image.asset('assets/matcha.jpeg', fit: BoxFit.fitWidth, height: 200,width: 400),
                subtitle: const Text('\nMatcha Green Tea Cupcake\nLorem ipsum dolor sit amet.'),
              ),
          ),
        ),
      ),
    );
  }
}
