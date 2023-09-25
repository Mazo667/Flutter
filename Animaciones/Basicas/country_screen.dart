import 'package:flutter/material.dart';

class CountyScrenn extends StatelessWidget {
  String imagePath;
  String country;
  String description;

  CountyScrenn(
      {super.key,
      required this.imagePath,
      required this.country,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(tag: country, child: Image.asset(imagePath)),
            Text(description)
          ],
        ),
      ),
    );
  }
}
