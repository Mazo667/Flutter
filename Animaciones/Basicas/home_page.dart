import 'package:animaciones/country_screen.dart';
import 'package:animaciones/photos_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Account"),
      ),
      body: Center(
        child: Column(
          children: [
            AnimatedTitle(),
            Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean interdum sed nulla vitae convallis. Proin laoreet turpis neque, quis hendrerit urna sollicitudin vel. Vestibulum lobortis pellentesque lacus, eu consectetur dui mollis eu. Suspendisse consectetur commodo quam fermentum dignissim. Phasellus fringilla fermentum nisi venenatis semper. Suspendisse pellentesque, massa quis finibus consectetur, ex nisi tristique massa, a finibus tellus metus non turpis. Vivamus volutpat augue in viverra varius. In felis lacus, euismod vitae suscipit quis, fringilla at est. Maecenas maximus id ligula nec blandit"),
            Column(
              children: [
                PaisCard(
                    country: "Argentina",
                    description: "Pais de LatinoAmerica",
                    imagePath: 'assets/images/argentinaIcon.png'),
                PaisCard(
                    country: "Alemania",
                    description: "Pais de Europa",
                    imagePath: 'assets/images/germanyIcon.png'),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PhotoScreen()));
                  },
                  child: Image.asset(
                    'assets/images/homero.png',
                    width: 150,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Go Back"))
          ],
        ),
      ),
    );
  }
}

class PaisCard extends StatelessWidget {
  String imagePath;
  String country;
  String description;

  PaisCard(
      {super.key,
      required this.imagePath,
      required this.country,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CountyScrenn(
                            country: country,
                            description: description,
                            imagePath: imagePath,
                          )));
            },
            child: Hero(
              tag: country,
              child: Image.asset(
                imagePath,
                width: 100,
                height: 100,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(country), Text(description)],
          )
        ],
      ),
    );
  }
}

class AnimatedTitle extends StatelessWidget {
  const AnimatedTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        //en child ponemos a los widgets que no van a realizar ningun cambio
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(seconds: 5),
        //en el builder hara los cambios
        builder: (BuildContext context, double value, Widget? child) {
          return Opacity(
            opacity: value,
            child: child,
          );
        },
        //en child ponemos a los widgets que no van a realizar ningun cambio
        child: const Text(
          "BIENVENIDO",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ));
  }
}
