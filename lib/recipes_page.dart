import 'package:flutter/material.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  _RecipesPageState createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  @override
  Widget build(BuildContext context) => Container(
      color: const Color.fromRGBO(252, 242, 214, 1),
      child: ListView(
        padding: const EdgeInsets.all(
            32), // used for an offset from each sides of a box
        children: [
          buildBackgroundCard('assets/pancake.jpg'),
          const SizedBox(height: 20),
          buildInvisibleBox(const Color.fromARGB(255, 153, 118, 94),
              const Color.fromARGB(255, 166, 192, 196)),
          const SizedBox(height: 20),
          buildBackgroundCard('assets/lunch2.jpg'),
          const SizedBox(height: 20),
          buildInvisibleBox(const Color.fromARGB(255, 153, 118, 94),
              const Color.fromARGB(255, 233, 180, 198)),
          const SizedBox(height: 20),
          buildBackgroundCard('assets/dinner1.jpg'),
          const SizedBox(height: 20),
          buildInvisibleBox(const Color.fromARGB(255, 153, 118, 94),
              const Color.fromARGB(255, 233, 132, 132)),
        ],
      ));

  Widget buildBackgroundCard(String link) {
    final urlBackgroundImage = link;

    return Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            print('Breakfast Generating');
          },
          child: Container(
            padding:
                const EdgeInsets.only(top: 16, right: 16, bottom: 16, left: 8),
            height: 60,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(urlBackgroundImage),
                fit: BoxFit.cover,
                /*  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.1),
                    BlendMode.darken,
                  ) */
              ),
            ),
          ),
        ));
  }

  Widget buildInvisibleBox(Color boxColor, Color recBox) {
    return Container(
      width: 1000,
      height: 90,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            //List<String>.generate(1000,(counter) => "Item $counter");
            15,
            (index) => buildRectangle(index, recBox),
          ),
        ),
      ),
    );
  }

  Widget buildRectangle(int index, Color recColor) {
    return Container(
        width: 120,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        height: 80,
        decoration: BoxDecoration(
          color: recColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Text(
          'Rectangle ${index + 1}',
          style: const TextStyle(color: Colors.white, fontSize: 18),
        )));
  }
}
