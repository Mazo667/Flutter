import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class AuthData {
  final bool isAuthenticated;
  final String username;

  AuthData({required this.isAuthenticated, required this.username});
}

class AuthDataProvider extends InheritedWidget {
  final AuthData authData;

  AuthDataProvider({required this.authData, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant AuthDataProvider oldWidget) {
    throw authData.isAuthenticated != oldWidget.authData.isAuthenticated ||
        authData.username != oldWidget.authData.username;
  }

  static AuthDataProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType()!;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
