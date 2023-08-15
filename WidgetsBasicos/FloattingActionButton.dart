import 'package:flutter/material.dart';

class FloattingButtonScreen extends StatefulWidget {
  const FloattingButtonScreen({super.key});

  @override
  State<FloattingButtonScreen> createState() => _FloattingButtonScreenState();
}

class _FloattingButtonScreenState extends State<FloattingButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boton flotante'),
      ),
      /*
      FloatingActionButton es un widget que se usa para crear un boton circular que flota sobre
      la pantalla, se usan comunmente para representar acciones principales o secundarias en una aplicacion
       */
      floatingActionButton: StandardFloatingButton(),
      // floatingActionButton: StandardFloatinButton(),
    );
  }
}

class ExtendedFloatingButton extends StatelessWidget {
  const ExtendedFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    /*
FloatingActionButton.extended es una variante, que se usa para crear un boton flotante con un icono y un texto
    */
    return FloatingActionButton.extended(
      onPressed: () {
        //Accion que realiza al presionarlo
      },
      //El texto del boton
      label: const Text('Recargar'),
      //Su icono
      icon: const Icon(Icons.refresh),
      backgroundColor: Colors.lightBlue,
    );
  }
}

class StandardFloatingButton extends StatelessWidget {
  const StandardFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      //Aca especificamos que accion va a realizar cuando se aprete el boton
      onPressed: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Boton Apretado')));
      },
      //si queremos un color diferente al predeterminado (azul)
      backgroundColor: Colors.amber,
      //aca modificamos el color del icono o Texto
      foregroundColor: Colors.black12,
      //Aca modificamos el tamaño del boton, si queremos que sea mas chico o no por defecto esto es false
      mini: false,
      //Este es el hijo que puede ser un texto o un icono
      child: const Icon(Icons.navigation),
    );
  }
}
