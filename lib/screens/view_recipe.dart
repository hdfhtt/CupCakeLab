import 'package:flutter/material.dart';
import '../instruction.dart';

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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(widget.title,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.left,
              ),
            ),
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
