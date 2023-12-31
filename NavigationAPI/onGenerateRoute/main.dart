import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp(
    home: MenuScreen(),
    title: "Navigation Example",
    //Declaro las rutas de la aplicacion
    routes: <String, WidgetBuilder> {
      '/perfil_usuario': (context) => PerfilUsuario("Maxi"),
    },
    onGenerateRoute: (routeSettings){
      if(routeSettings.name == "/perfil_usuario"){
        var uri = Uri.parse(routeSettings.name!);
        if (uri.pathSegments.length >= 2){
          var id = uri.pathSegments[1];
          return MaterialPageRoute(builder: (context) => PerfilUsuario(id));
        }
      }else{
        return null;
      }
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
                    //le paso como argumento un nombre de usuario
                    Navigator.pushNamed(context, "/perfil_usuario", arguments: 'maxi');
                  },
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
  final String userId;
  PerfilUsuario(this.userId, {super.key});

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
              Text('User Id:  $userId'),
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
              }, child: const Text("Volver"))
            ],
          ),
        )
    );
  }
