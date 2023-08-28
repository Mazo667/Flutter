import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Mi Aplicacion',
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
      child: Column(
        children: [
          const SizedBox(height: 100),
          const Text('Este es un Elevated Button', style: TextStyle(fontSize: 30)),
          ElevatedButton(onPressed: () {}, child: const Text('Elevated Button')),
          const SizedBox(height: 100),
          const Text('Este es un Text Button', style: TextStyle(fontSize: 30)),
          TextButton(onPressed: () {}, child: const Text('Text Button')),
          const SizedBox(height: 100),
          const Text('Este es un Outlined Button', style: TextStyle(fontSize: 30)),
          OutlinedButton(onPressed: () {}, child: const Text('Outlined Button')),
          const SizedBox(height: 100),
          const Text('Este es un Icon Button', style: TextStyle(fontSize: 30)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.access_time)),
        ],
      ),
    ),
      );
  }
}
