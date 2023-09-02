import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    title: 'Mi Aplicacion',
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Simple State"),
      ),
//el widget ChangeNotifierProvider se utiliza para compartir datos entre widgets, los widgets que dependan del ChangeNotifierProvider
    //se actualizaran cuando el estado del ChangeNotifier cambie
      body: ChangeNotifierProvider(
        //el parametro create es una funcion que se utiliza para crear una instancia del ChangeNotifier
        create: (context) => ColorSettings(),
        //el parametro child es el widget que se va a mostrar
        child: const SettingScreen(),
      ),
    ),
  ));
}
//Creo una clase que extienda de ChangeNotifier
class ColorSettings extends ChangeNotifier {
  bool useRed = false;

  //Creo dos metodos para cambial el valor de useRed
  void setRed() {
    useRed = true;
    //se utiliza para notificar a los widgets que dependen del proveedor que el estado ha cambiado
    notifyListeners();
  }

  void unsetRed() {
    useRed = false;
    notifyListeners();
  }
}

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        ColorsSelection(),
        Text("Rojo"),
        ColoredIcon(),
      ],
    );
  }
}

class ColorsSelection extends StatelessWidget {
  const ColorsSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Creo un widget Consumer que escucha los cambios de estado en ColorSettings
    //El consumer toma un widget como parametro y devuelve un widget envuelto
    return Consumer<ColorSettings>(builder: (context, colorSettings, child) {
      return Row(
        children: [
          Checkbox(
            value: colorSettings.useRed,
            //Cuando el checkbox cambie de valor llamamos al metodo onCheckBoxPressed
            onChanged: (isChecked) => {onCheckBoxPressed(isChecked, context)},
          ),
        ],
      );
    });
  }

  void onCheckBoxPressed(bool? value, BuildContext context) {
    var colorSettings = Provider.of<ColorSettings>(context, listen: false);
    if (value!) {
      colorSettings.setRed();
    } else {
      colorSettings.unsetRed();
    }
  }
}

class ColoredIcon extends StatelessWidget {
  const ColoredIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorSettings>(builder: (context, colorSettings, child) {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.favorite,
              color: colorSettings.useRed ? Colors.red : Colors.black38,
              size: 50));
    });
  }
}
