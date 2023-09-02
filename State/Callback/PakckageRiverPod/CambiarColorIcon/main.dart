import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp( ProviderScope(child:
      MaterialApp(
    title: 'Mi Aplicacion',
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Simple RiverPod App"),
      ),
      body: SettingScreen(),
      ),
    ),
  )
  );
}
// Este es el state (estado)
class ColorSettings {
  final bool useRed;
  const ColorSettings(this.useRed);
}

//StateNotifier
class ColorSettingsNotifier extends StateNotifier<ColorSettings>{
  ColorSettingsNotifier(ColorSettings state) : super(state);

  void setRed(){
    state = const ColorSettings(true);
  }
  void unsetRed(){
    state = const ColorSettings(false);
  }
}

//Creo mi provider de forma global  (StateNotifierProvider)
final colorSettingsProvider = StateNotifierProvider<ColorSettingsNotifier,ColorSettings>((_) => ColorSettingsNotifier(const ColorSettings(true)));


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


class ColorsSelection extends ConsumerWidget {
  const ColorsSelection({Key? key}) : super(key: key);

  @override
  //
  Widget build(BuildContext context, WidgetRef ref) {
    //obtiene la instancia del provider ColorSettingsProvider del contexto actual
    //el widget ref.watch es una funcion proporcionada por RiverPod, se usa para obtener el valor
    //de un provider en el contexto actual.
    var colorSettings = ref.watch(colorSettingsProvider);
    return Row(
      children: [
        Checkbox(
          value: colorSettings.useRed,
          onChanged: (isChecked) =>
          {onCheckBoxPressed(isChecked, ref, context)},
        ),
      ],
    );
  }

  void onCheckBoxPressed(bool? isChecked,WidgetRef ref,BuildContext context) {
    var colorSettingsNotifier = ref.read(colorSettingsProvider.notifier);
    if (isChecked!) {
      colorSettingsNotifier.setRed();
    } else {
      colorSettingsNotifier.unsetRed();
    }
  }
}

class ColoredIcon extends ConsumerWidget {
  const ColoredIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var colorSettings = ref.watch(colorSettingsProvider);
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.favorite,
              color: colorSettings.useRed ? Colors.red : Colors.black38,
              size: 50)
      );
  }
}
