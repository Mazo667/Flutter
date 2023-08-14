import 'package:flutter/material.dart';

import 'ImageScreen.dart';

void main() {
  runApp(const WidgetSampleApp());
}

class WidgetSampleApp extends StatelessWidget {
  const WidgetSampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Widgets Basicos',
      home: ImageScreen(),
    );
  }
}
