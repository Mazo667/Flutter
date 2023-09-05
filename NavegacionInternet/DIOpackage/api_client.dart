import 'package:dio/dio.dart';
import 'package:ejemplo_1/main.dart';
import 'dart:convert';

class ApiClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://jsonplaceholder.typicode.com",
    //Tiempo de espera de conexion
    connectTimeout: const Duration(seconds: 5),
    //recibir tiempo de espera
    receiveTimeout: const Duration(seconds: 3),
    )
  );

  ApiClient(){
    //Añado un Interceptors
  _dio.interceptors.add(Logger());
  }

  Future<User> getUser(String userId) async {
   Response response = await _dio.get("/users/$userId");
   return User.fromJson(response.data);
   // _controllerUserInfo.value = TextEditingValue(text: response.body);
  }
//Metodo de una solicitud de Post, envia datos a un servidor
  Future<Post> createPost(String title, String body) async{
    var newPost = jsonEncode(<String, String>{
      'title': title,
      'body' : body,
    });

    var response = await _dio.post('/posts',data: newPost);
    return Post.fromJson(response.data);
  }

}
/*
es una clase que se puede utilizar para interceptar solicitudes y respuestas HTTP.
Los interceptores se pueden utilizar para agregar encabezados, establecer cookies,
manejar errores y realizar otras tareas de procesamiento de solicitudes.
 */
class Logger extends Interceptor{
  //Este método se llama antes de que se envíe una solicitud HTTP.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("REQUEST[${options.method}] => PATH: ${options.path}");
    super.onRequest(options, handler);
  }
//Este método se llama después de que se haya recibido una respuesta HTTP.
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        "RESPONSE[${response.statusCode}] => BODY: ${response.data.toString()}");
    super.onResponse(response, handler);
  }
//Este método se llama si se produce un error durante una solicitud HTTP.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    super.onError(err, handler);
  }
}
