import 'package:flutter/material.dart';

void main() {
runApp( MaterialApp(
  home: MenuScreen(),
  title: "Navigation Example",
  //Declaro las rutas de la aplicacion
  routes: <String, WidgetBuilder> {
    '/perfil_usuario': (context) => PerfilUsuario()
  },
  )
);
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu Principal"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text("Abir Segunda Pantalla"),
              onPressed: () {
                //Navegar entre pantallas
                Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen()));
              },
            ),
            ElevatedButton(
              child: const Text("Abir Pantalla Perfil Usuario"),
              onPressed: () {
                //Navego en una pantalla llamada perfil_usuario
                Navigator.pushNamed(context, "/perfil_usuario");
              }
            ),
          ],
        )
     )
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Segunda Pantalla"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Volver al Menu Principal"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class PerfilUsuario extends StatelessWidget {
  const PerfilUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil Usuario"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 60),
            const Text("Maximiliano"),
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
            }, child: const Text("Volver"))
          ],
        ),
      )
    );
  }
}

