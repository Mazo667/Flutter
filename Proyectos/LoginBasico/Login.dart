import 'package:chat_app/screens/HomePage.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Creamos una Key para nuestro form, lo identificamos para crearlo de forma unica
  //esta configurado como final para que despues no cambie
  final _formKey = GlobalKey<FormState>();
  //Definimos los controladores, un controlador se usa para leer los valores de entrada
  //Usando un controlador podremos controlar el componente usado
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //Creamos la variable booleana si la constraseña es visible
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(),
                      labelText: "Email",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please insert your email";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: passwordController,
                    //ocultamos la contraseña
                    obscureText: _passwordVisible,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            icon: Icon(
                                //Si el valor boleano de es verdadero se ve, si es falso no se ve
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please insert your password";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //Navegar a la pagina pricipal del usuario si la informacion es correcta
                        if (emailController.text == "maxi@gmail.com" &&
                            passwordController.text == "1234") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage(email: emailController.text)));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Invalid Credentials')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill input')));
                      }
                    },
                    child: const Text("Submit"))
              ],
            ),
          )),
    );
  }
}
