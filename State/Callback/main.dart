import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Mi Aplicacion',
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Simple State"),
      ),
      body: SettingScreen(),
    ),
  ));
}

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}


class _SettingScreenState extends State<SettingScreen> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Aca llamo a mi widget que contiene el checkbox
        ColorsSelection(isChecked: isChecked, onPressed: checkBoxPressed),
        const Text("Rojo"),
        ColoredIcon(isChecked),

      ],
    );
  }

  void checkBoxPressed(bool? value) {
    //Llamamos al metodo SetState() para que la pantalla se re dibuje
    setState(() {
      //La expresion asigna el valor contrario al booleano
      isChecked = value!;
    });
  }
}

class ColorsSelection extends StatelessWidget {
  //Declaro los atributos
  final bool isChecked;
  //Es un tipo de devolucion de llamada que se utiliza para indicar que se ha producido un evento.
  //El parametro de la devolucion de llamada es un bool? que es un tipo de datos que puede ser null o un valor booleano
  final ValueChanged<bool?> onPressed;

  const ColorsSelection({super.key,required this.isChecked,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: isChecked, onChanged: onPressed),
      ],
    );
  }
}

class ColoredIcon extends StatelessWidget {
  final bool showColor;
  //Creo un constructor, que toma dos parametros, showColor que es un booleano que indica si el color debe ser cambiado o no
  //key es un objeto que permite identificar al widget
  const ColoredIcon(this.showColor,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon( Icons.favorite,
        color: showColor ? Colors.red : Colors.black38,
      size: 50,),
    );
  }
}
