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
        create: (_) => ColorSettingsBloc(const ColorSettings(false)),
        child: const SettingScreen(),
      )),
  ));
}

// Este es el state (estado)
class ColorSettings {
  final bool useRed;
  const ColorSettings(this.useRed);
}
//Creo una clase abstracta que es la generalizacion de todos los eventos
abstract class ColorSettingsEvent{
  const ColorSettingsEvent();
}

//Creamos los eventos
class SetRedColorEvent extends ColorSettingsEvent{
  const SetRedColorEvent();
}

class UnSetRedColorEvent extends ColorSettingsEvent{
  const UnSetRedColorEvent();
}
//Creo el bloc que recibe el event y el State
class ColorSettingsBloc extends Bloc<ColorSettingsEvent,ColorSettings>{
  //Constructor, con el estado inicial del State
  ColorSettingsBloc(ColorSettings initState) : super(const ColorSettings(false)){
    //Aca declaro que eventos va escuchar y como va a reaccionar
    on<SetRedColorEvent> ((event,emit){
      //Logica cuando reciba este evento
      //emitimos un nuevo state
      emit(const ColorSettings(true));
    });
    on<UnSetRedColorEvent> ((event,emit){
      //Logica cuando reciba este evento
      emit(const ColorSettings(false));
    });
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

class ColorsSelection extends  StatelessWidget {
  const ColorsSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorSettingsBloc,ColorSettings>(
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
    var colorSettingsBloc = context.read<ColorSettingsBloc>();
    if (isChecked!) {
      //Se agrega el estado a la cola del estado
      colorSettingsBloc.add(const SetRedColorEvent());
    } else {
      colorSettingsBloc.add(const UnSetRedColorEvent());
    }
  }
}


class ColoredIcon extends StatelessWidget {
  const ColoredIcon({super.key});

  @override
  Widget build(BuildContext context) {
    //BlocBuilder se encarga de crear el widget en respuesta a nuevos estados, necesita un builder y un Bloc
    return BlocBuilder<ColorSettingsBloc,ColorSettings>(
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
