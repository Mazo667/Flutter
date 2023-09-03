import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(NetworkSampleApp());
}

class NetworkSampleApp extends StatelessWidget {
  const NetworkSampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserInfoScreen(userId: 'maxi-01',),
    );
  }
}

class UserInfoScreen extends StatelessWidget {
  final String userId;
  final TextEditingController _controllerUserInfo = TextEditingController();
  final TextEditingController _controllerPostResponse = TextEditingController();

  UserInfoScreen({Key? key, required this.userId}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informacion de Usuario"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Pedir datos de usuario"),
                ElevatedButton(
                    onPressed: () {
                      getUserInfo('1');
                    },
                    child: const Text("Consultar datos")),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  controller: _controllerUserInfo,
                  maxLines: 10,
                  minLines: 4,
                ),
                const Padding(padding: EdgeInsets.only(top: 30)),
                const UserDataWidget(),
                const Padding(padding: EdgeInsets.only(bottom: 30)),
                ElevatedButton(
                    onPressed: () {
                      createPost("Mi nuevo Post");
                    },
                    child: const Text("Crear Post")),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  controller: _controllerPostResponse,
                  maxLines: 10,
                  minLines: 2,
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

    void getUserInfo(String userId) async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/users/$userId");
    var response = await http.get(url);
    _controllerUserInfo.value = TextEditingValue(text: response.body);
    }

  void createPost(String title) async{
    var newPost = jsonEncode(<String, String>{
      'title': title,
      'body' : 'este es mi nuevo Post',
      'userId' : '1',
    });
    var postHeaders = <String, String>{
      'Content-Type':'application/json; charset=UTF-8',
    };
    var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    var response = await http.post(url,body: newPost,headers: postHeaders);
    //Si la respuesta es 201 es un post hecho satisfactoriamente
    print('Response status: ${response.statusCode}');
    _controllerPostResponse.value = TextEditingValue(text: response.body);
  }
}
//loading widget, para esperar la respuesta
class UserDataWidget extends StatefulWidget {
  const UserDataWidget({super.key});

  @override
  State<UserDataWidget> createState() => _UserDataWidgetState();
}

class _UserDataWidgetState extends State<UserDataWidget> {
  late Future<User> futureUserData;

  @override
  void initState() {
    super.initState();
    futureUserData = getUserInfoWithModel("1");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: futureUserData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const Text("Datos del usuario"),
                TextField(
                  controller:
                  TextEditingController(text: snapshot.data!.username),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Username",
                  ),
                ),
                TextField(
                  controller: TextEditingController(text: snapshot.data!.email),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Email",
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }

  Future<User> getUserInfoWithModel(String userId) async{
    var url = Uri.parse("https://jsonplaceholder.typicode.com/users/$userId");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return Future.delayed(const Duration(seconds: 2), () {
        return User.fromJson(jsonDecode(response.body));
      });
    } else {
      throw Exception("Error al obtener datos del usuario");
    }
    }

  }



//Mapeo la respuesta JSON a una clase
class User{
  final int id;
  final String name;
  final String username;
  final String email;

  User(this.id,this.name,this.username,this.email);

  factory User.fromJson(Map<String, dynamic> json){
    return User(json['id'], json['name'], json['username'], json['email']);
  }
}

