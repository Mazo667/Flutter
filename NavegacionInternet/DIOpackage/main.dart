import 'api_client.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(NetworkSampleApp());
}

class NetworkSampleApp extends StatelessWidget {
  const NetworkSampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
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
                      ApiClient().getUser('1').then((user) => {
                        _controllerUserInfo.value = TextEditingValue(text: user.name)
                      });
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
                      ApiClient().createPost('Mi nuevo Post','este es el texto del body').then((post) => {
                        _controllerPostResponse.value = TextEditingValue(text: post.id.toString())
                      });
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
    futureUserData = ApiClient().getUser('1') as Future<User>;
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

class Post {
  final int id;
  final String title;
  final String body;

  Post(this.id,this.title,this.body);

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(json['id'],json['title'],json['body']);
  }
}
