import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: KeysApp(),
  ));
}

class KeysApp extends StatefulWidget {
  const KeysApp({super.key});

  @override
  State<KeysApp> createState() => _KeysAppState();
}

class _KeysAppState extends State<KeysApp> {
  //Variables estaticas para identificar los dos colores (rojo y verde)
  static Color rojo = Colors.red;
  static Color verde = Colors.green;
  //Arreglo de dos intancias de la clase ColorCelda
  var celdas = [
    ColorCelda(
      color: rojo,
      label: "Rojo",
      key: ObjectKey(rojo),
    ),
    ColorCelda(
      color: verde,
      label: "Verde",
      key: ObjectKey(verde),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ejemplo de Keys"),
      ),
      body: Center(
        child: Column(
          children: celdas,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //Invocamos al metodo swapColors
        onPressed: _swapColors,
        child: const Icon(Icons.update_rounded),
      ),
    );
  }

  _swapColors() {
    setState(() {
      var temp = celdas[0];
      celdas[0] = celdas[1];
      celdas[1] = temp;
    });
  }
}

class ColorCelda extends StatefulWidget {
  //Defino los dos parametros que va a recibir
  final Color color;
  final String label;
  // y los hago que sean requiridos
  const ColorCelda({
    required this.color,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  State<ColorCelda> createState() => _ColorCeldaState();
}

class _ColorCeldaState extends State<ColorCelda> {
  late Color color;
  late String label;
  //El metodo initState() se llama una vez cuando el widget se inserta en el arbol de Widgets.
  //El metodo super.initState() se llama automaticamente por Flutter.
  @override
  void initState() {
    super.initState();
    color = widget.color;
    label = widget.label;
  }

  @override
  Widget build(BuildContext context) => Container(
        color: color,
        //El ListTitle puede verse como un contenedor de una lista que facilita poner Strings
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          title: Text(label),
        ),
      );
}
