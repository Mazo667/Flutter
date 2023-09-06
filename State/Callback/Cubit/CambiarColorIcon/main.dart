import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MaterialApp(
    title: 'Mi Aplicacion',
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Bloc App"),
      ),
      body: BlocProvider(
        create: (_) => ColorSettingCubit(const ColorSettings(true)),
        child: const SettingScreen(),
      )),
  ));
}

// Este es el state (estado)
class ColorSettings {
  final bool useRed;
  const ColorSettings(this.useRed);
}

//Una clase Cubit se extiende de la clase BlocBase y puede ampliarse para gestionar cualquier tipo de estado.
//en esta clase estara reflejada los cambios que pueden realizarse
//necesitamos definir el tipo de estado que Cubit adminastrara en este caso ColorSettings
class ColorSettingCubit extends Cubit<ColorSettings>{
  //al crear el cubit debemos especificar el estado inicial con super.
  ColorSettingCubit(super.initialState);
  //Creamos los metodos para cambiar los estados
  void setRed(){
    //Cada Cubit tiene la capacidad de generar un nuevo estado a través de emit
    emit(const ColorSettings(true));
  }
  void unsetRed(){
    //El emitmétodo está protegido, lo que significa que solo debe usarse dentro de un archivo Cubit
    emit(const ColorSettings(false));
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

//Clase ejemplo de un contador
class CounterCubit extends Cubit<int>{
  CounterCubit() : super(0);
  void increment() => emit(state+1);
}


class ColorsSelection extends  StatelessWidget {
  const ColorsSelection({Key? key}) : super(key: key);

  @override
  //
  Widget build(BuildContext context) {
    return BlocBuilder<ColorSettingCubit,ColorSettings>(
        builder: (context, colorSettingsState) {
          return Row(
            children: [
              Checkbox(
                value: colorSettingsState.useRed,
                onChanged: (isChecked) =>
                {onCheckBoxPressed(isChecked,context)},
              ),
            ],
          );
        }
    );
  }
  void onCheckBoxPressed(bool? isChecked, BuildContext context) {
    var colorSettingsCubit = context.read<ColorSettingCubit>();
    if (isChecked!) {
      colorSettingsCubit.setRed();
    } else {
      colorSettingsCubit.unsetRed();
    }
  }
}


class ColoredIcon extends StatelessWidget {
  const ColoredIcon({super.key});

  @override
  Widget build(BuildContext context) {
    //BlocBuilder se encarga de crear el widget en respuesta a nuevos estados, necesita un builder y un Bloc
    return BlocBuilder<ColorSettingCubit,ColorSettings>(
        builder: (context, colorSettingsState) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.favorite,
                  color: colorSettingsState.useRed ? Colors.red : Colors.black38,
                  size: 50)
          );
        }
    );
  }
}
