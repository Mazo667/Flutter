import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String idiomaSeleccionado = 'en';
  String traduccion = "";
  bool cargando = false;
  TextEditingController controller = TextEditingController();

  Widget buildLanguageIcon(String idioma, String imagePath) {
    return GestureDetector(
      child: Pais(pais: idioma, imagen: imagePath),
      onTap: () {
        setState(() {
          idiomaSeleccionado = idioma;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TRANSLATE THIS")),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
            child: Column(
          children: [
            const Text("Introduce el texto a traducir",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
            TextField(
              controller: controller,
            ),
            const Text("Seleccione el idioma en que se va a traducir",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildLanguageIcon('pt', 'assets/images/portugalIcon.png'),
                  buildLanguageIcon('en', 'assets/images/britishIcon.png'),
                  buildLanguageIcon('fr', 'assets/images/franceIcon.png'),
                  buildLanguageIcon('de', 'assets/images/germanyIcon.png'),
                ],
              ),
            ),
            Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Idioma es: " + idiomaSeleccionado),
            )),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    cargando = true;
                  });
                  traducirTexto(idiomaSeleccionado, controller.text);
                },
                child: const Text("Traducir")),
            Card(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: cargando
                      ? const CircularProgressIndicator()
                      : Text(traduccion)),
            )
          ],
        )),
      ),
    );
  }

  void traducirTexto(String idiomaSeleccionado, String text) async {
    var translator = await GoogleTranslator()
        .translate(text, from: 'es', to: idiomaSeleccionado);
    setState(() {
      cargando = false;
      traduccion = translator.text;
    });
  }
}

class Pais extends StatelessWidget {
  final String pais;
  final String imagen;
  const Pais({super.key, required this.pais, required this.imagen});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(imagen, width: 48),
            Text(pais, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
