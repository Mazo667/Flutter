import 'dart:math';

import 'package:flutter/material.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

/* TickerProviderStateMixin es un mixin en Flutter que permite a un widget crear un Ticker.
 Un Ticker es un objeto que llama a una devolución de llamada de tick una vez por fotograma de animación.
  Los Ticker se utilizan comúnmente para animar widgets en Flutter.
 */
class _PhotoScreenState extends State<PhotoScreen>
    with TickerProviderStateMixin {
  /* Un AnimationController en Flutter es un objeto que controla el progreso de una animación.
   Los AnimationControllers se utilizan comúnmente para animar propiedades de widgets,
   como la posición, el tamaño, el color y la opacidad.
    Un AnimationController tiene las siguientes propiedades:
    duration: La duración de la animación.
    value: El valor actual de la animación.
    isAnimating: Un valor booleano que indica si la animación está en curso
   */
  late final AnimationController _rotateController =
      AnimationController(duration: const Duration(seconds: 5), vsync: this);
  late final AnimationController _colorController =
      AnimationController(duration: const Duration(seconds: 5), vsync: this);
  late final AnimationController _outController =
      AnimationController(duration: const Duration(seconds: 5), vsync: this);
/* Luego, se puede usar el método animate() para crear una animación que interpole entre dos valores.
 La animación se iniciará cuando se llame al método forward(). Se puede detener la animación llamando al método stop().
 */
  late final Animation<Color?> _colorAnimation =
      ColorTween(begin: Colors.black12, end: Colors.green)
          .animate(_colorController);
  late final Animation<Offset> _outAnimation =
      Tween<Offset>(begin: Offset.zero, end: const Offset(2.0, 0.0)).animate(
          CurvedAnimation(parent: _outController, curve: Curves.bounceOut));
  @override
  void initState() {
    //agrego un listener, para que escuche si la animacion ya se completo
    _rotateController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _rotateController.reset();
      }
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _rotateController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotateController.value * 2 * pi,
                  child: Image.asset(
                    'assets/images/homero.png',
                    width: 150,
                  ),
                );
              },
            ),
            ElevatedButton(
                onPressed: () {
                  //llamo al metodo forward para dar play a la animacion
                  _rotateController.forward();
                },
                child: const Text("Rotar")),
            /* AnimatedBuilder es un widget en Flutter que reconstruye su hijo en función del valor actual
             de un AnimationController. El AnimatedBuilder también tiene un parámetro builder que es una función
             que se usa para construir el hijo del AnimatedBuilder.
              La función builder se llama cada vez que cambia el valor del AnimationController.
             */
            AnimatedBuilder(
              animation: _colorController,
              builder: (context, child) {
                return ColorFiltered(
                  colorFilter:
                      ColorFilter.mode(_colorAnimation.value!, BlendMode.color),
                  child: Image.asset(
                    'assets/images/homero.png',
                    width: 150,
                  ),
                );
              },
            ),
            ElevatedButton(
                onPressed: () {
                  _colorController.forward();
                },
                child: const Text("Color")),
            SlideTransition(
              position: _outAnimation,
              child: Image.asset(
                'assets/images/homero.png',
                width: 150,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  _outController.forward();
                },
                child: const Text("Salir")),
          ],
        ),
      ),
    );
  }
}
