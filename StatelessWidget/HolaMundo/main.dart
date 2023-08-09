import 'package:flutter/material.dart';

void main() {
  //MaterialApp es un widget de Flutter que proporciona una estructura basica para una app seguiendo las directrices de Material Design de Google
  runApp(MaterialApp(
    title: 'Mi Aplicacion',
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Scaffold es un widget que proporciona una estructura basica para una pantalla con un AppBar y un Body
    return Scaffold(
      appBar: AppBar(title: Text('Inicio'),
      ),
      body: const Center(child: Text('Hola Mundo'),
      ),
    );
  }
}
