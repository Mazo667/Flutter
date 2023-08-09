import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
//Clase para representar la informacion de autentificacion
class AuthData {
  final bool isAuthenticated;
  final String username;

  AuthData({required this.isAuthenticated, required this.username});
}
//Este widget almacena la informacion de autentificacion que queremos compartir en toda la aplicacion
class AuthDataProvider extends InheritedWidget {
  final AuthData authData;

  AuthDataProvider({required this.authData, required Widget child})
      : super(child: child);

  //Metodo para verificar si un Widget dependiente necesita reconstruirse
  @override
  bool updateShouldNotify(covariant AuthDataProvider oldWidget) {
    throw authData.isAuthenticated != oldWidget.authData.isAuthenticated ||
        authData.username != oldWidget.authData.username;
  }

  //Metodo estatico para acceder al InheritedWidget desde el contexto
  static AuthDataProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType()!;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Creamos una instancia de AuthData y la pasamos a AuthDataProvider
    final authData = AuthData(isAuthenticated: true, username: 'exampleuser');

    return AuthDataProvider(
      authData: authData,
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Usamos AuthDataProvider.of(context) para acceder a la informacion de autentificacion y mostrar mensajes personalizados segun el estado de autentificacion.
    final authData = AuthDataProvider.of(context).authData;

    return Scaffold(
      appBar: AppBar(
        title: Text('Inherited Widget Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Usuario: ${authData.username}'),
            SizedBox(height: 20),
            if (authData.isAuthenticated)
              Text('Bienvenido, ${authData.username}')
            else
              Text('Por favor inicie sesion'),
          ],
        ),
      ),
    );
  }
}
