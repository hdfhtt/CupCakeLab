import 'package:flutter/material.dart';

class ViewRecipeScreen extends StatefulWidget {
  const ViewRecipeScreen({super.key, required this.id, required this.title, required this.image});

  final int id;
  final String title;
  final String image;

  @override
  _ViewRecipeScreenState createState() => _ViewRecipeScreenState();
}

class _ViewRecipeScreenState extends State<ViewRecipeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: GestureDetector(
        onTap: () => Navigator.of(context).pop(), 
              child: Container(
            height: 58.0,
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
              color: Colors.pink,
            ),
            child: const Text(
              "Back",
              style: TextStyle(
                fontSize: 24.0,
                fontFamily: "HellixBold",
                color: Colors.white,
              ),
            ),
          ),
      ),
      body:
       SingleChildScrollView(
         child: Container(
          margin: const EdgeInsets.only(
            top: 64.0,
            bottom: 28.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 28.0),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  )
                )
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Text(widget.title,
                  style: TextStyle(fontSize: 36.0, fontFamily: "HellixBold"),
                ),
              ),
              const SizedBox(height: 24.0),
              Image.network(widget.image,
                height: 250.0,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24.0),
              const Text(
                "Ingredients",
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: "HellixBold",
                ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                ),
                const SizedBox(height: 24.0),
              const Text(
                "Instructions",
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: "HellixBold",
                ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                ),
            ],
          )
             ),
       ),
    );
  }
}
