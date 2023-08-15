import 'package:flutter/material.dart';

class GesturesDetectionScreen extends StatefulWidget {
  const GesturesDetectionScreen({super.key});

  @override
  State<GesturesDetectionScreen> createState() =>
      _GesturesDetectionScreenState();
}

class _GesturesDetectionScreenState extends State<GesturesDetectionScreen> {
  bool _lightIsOn = false;
  Color _lighColor = Colors.yellow.shade600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deteccion de Gestos'),
      ),
      body: Container(
        alignment: FractionalOffset.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.lightbulb_outline,
                color: _lightIsOn ? _lighColor : Colors.black87,
                size: 60,
              ),
            ),
            GestureDetector(
              //GestureDetector ofrece muchos tipos de gestos
              //especificaremos que tiene que hacer cuando se presiona
              onTap: () {
                setState(() {
                  _lightIsOn = !_lightIsOn;
                });
              },
              //El gesture Detector tiene un hijo
              child: Container(
                color: Colors.blue,
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Encender la Luz',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
