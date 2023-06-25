import 'package:flutter/material.dart';
import '../instruction.dart';

/// ViewRecipeScreen is a stateful widget, which show information of a selected
/// recipe with its information accordingly.
class ViewRecipeScreen extends StatefulWidget {
  const ViewRecipeScreen({super.key, required this.id, required this.title, required this.image});

  final int id;
  final String title;
  final String image;

  @override
  ViewRecipeScreenState createState() => ViewRecipeScreenState();
}

late Future<List<Instruction>> futureRecipeInstructions;

class ViewRecipeScreenState extends State<ViewRecipeScreen> {

  @override
  void initState() {
    super.initState();

    // Fetch the recipe instructions when initiated.
    futureRecipeInstructions = fetchInstruction(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.surfaceVariant;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        scrolledUnderElevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: IconButton(
              // Show add to favorite SnackBar when button is pressed.
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Added to favorite.'),
                ));
              },
              isSelected: false,
              selectedIcon: const Icon(Icons.favorite),
              icon: const Icon(Icons.favorite_outline),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            // This will show the title of the recipe.
            SizedBox(
              width: double.infinity,
              child: Text(widget.title,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.left,
              ),
            ),

            // This will show the image of the recipe.
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(widget.image,
                  fit: BoxFit.fitWidth,
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,
                ),
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: Text('Instructions',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 8.0),

            /// The following will generate a list of instruction steps using
            /// FutureBuilder() and ListView.builder().
            FutureBuilder(
              future: futureRecipeInstructions,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: LinearProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final step = snapshot.data![index].number;
                      final instruction = snapshot.data![index].step;

                      return Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text('Step $step',
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.left,
                            ),
                          ),

                          SizedBox(
                            width: double.infinity,
                            child: Text(instruction,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    }
                  );
                  } else {
                    return const Center(child: Text('Instructions are not yet available.'));
                  }
                }
              ),
          ],
        ),
      ),
    );
  }
}
