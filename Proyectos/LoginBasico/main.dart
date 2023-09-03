import 'package:flutter/material.dart';
import 'screens/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tab Bar Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        //Modo oscuro
        //brightness: Brightness.dark,
      ),
      home: const Scaffold(body: Login()),
    );
  }
}
