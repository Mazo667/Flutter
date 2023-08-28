import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
//Creo una clase app que retorne un MarialApp Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'StatefulWidget Example',
      home: CounterApp(),
    );
  }
}
//Creo una clase Contador que herede StatefullWidget
class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  _CounterAppState createState() {
    return _CounterAppState();
  }
}
//Creo una clase privada con _ que herede de State<CounterApp>, esta clase contiene el estado mutable (valor del contador) y un metodo para modificarlo
class _CounterAppState extends State<CounterApp> {
  int _counter = 0;
//Definimos un metodo para que aumenta el contador en uno
  void _incrementCounter() {
    //utilizamos el metodo setState para decirle a Flutter que el estado ha cambiado y la interfaz de usuario necesita actualizarse
    setState(() {
      _counter++;
    });
  }
//En el metodo build() construimos la interfaz de usuario utilizando el valor actual de contador y un boton flotante que llama a _incrementCounter() cuando se presiona
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Hola, el contador es $_counter")),
      floatingActionButton: FloatingActionButton(
        //Aca decimos que al presionar el boton se llame al metodo de incrementar contador
        onPressed: _incrementCounter,
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
