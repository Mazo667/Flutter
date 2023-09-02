import 'package:flutter/material.dart';

void main() {
runApp(const MaterialApp(
  home: MenuScreen(),
  title: "Navigation Example",
  )
);
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu Principal"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Abir pantalla Siguiente"),
          onPressed: () {
            //Navegar entre pantallas
            Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen()));
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Segunda Pantalla"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Volver al Menu Principal"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
