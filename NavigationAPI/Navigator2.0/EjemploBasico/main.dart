import 'package:flutter/material.dart';

void main() {
  runApp(NavigationControl());
}

class NavigationControl extends StatefulWidget {
  const NavigationControl({super.key});

  @override
  State<NavigationControl> createState() => _NavigationControlState();
}

class _NavigationControlState extends State<NavigationControl> {
  String? screenSelected = "";
  String currentUserId = "";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigator(
        //Objetos inmmutables que se usan para iniciar el stack de historial del Navigator
        pages: [
          //MaterialPage se utiliza para representar una pantalla
          MaterialPage(child: MenuScreen( onNavigate: (screenName) {
            setState(() {
              screenSelected = screenName;
            });
            //onNavigatePerfilUsuario se usa para navegar a la pantalla PerfilUsuario y pasar la IdUsuario como argumento
          },onNavigatePerfilUsuario: (userId){
            setState(() {
              screenSelected = PerfilUsuario.screenName;
              currentUserId = userId;
            });
          },
          )),
          if (screenSelected == SecondScreen.screenName)
            MaterialPage(child: SecondScreen()),
          if (screenSelected == PerfilUsuario.screenName)
            MaterialPage(child: PerfilUsuario(currentUserId)),
        ],
        //onPopPage se utiliza para manejar el evento de una pantalla que se elimina de la pila de navegacion
        onPopPage: (route, result){
          //el metodo didPop se utiliza para determinar si la pantalla se elimino de la pila de navegacion por que el usuario hizo clic en el boton hacia atras
          if (route.didPop(result)){
            return true;
          }else{
            return false;
          }
        },
      ),
      title: "Navigation Example",
    );
  }
}

typedef IdUser = String;

class MenuScreen extends StatelessWidget {
  //Atributos
  final ValueChanged<String> onNavigate;
  final ValueChanged<IdUser> onNavigatePerfilUsuario;
//Constructor
  const MenuScreen({required this.onNavigate,required this.onNavigatePerfilUsuario, Key? key}) : super(key: key);

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
                    onNavigate(SecondScreen.screenName);
                  },
                ),
                ElevatedButton(
                  child: const Text("Abir Pantalla Perfil Usuario"),
                  onPressed: () {
                    onNavigatePerfilUsuario("Maxi");
                    onNavigate(PerfilUsuario.screenName);
                  },
                ),
              ],
            )
        )
    );
  }
}

class SecondScreen extends StatelessWidget {
  static const String screenName = "secondScreen";
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
  static const String screenName = "perfilUsuario";
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
}
