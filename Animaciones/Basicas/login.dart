import 'package:animaciones/home_page.dart';
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

  bool _validatorIsActivated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: AnimatedContainer(
          width: 400,
          height: _validatorIsActivated ? 370 : 325,
          decoration: BoxDecoration(
              color: Colors.tealAccent,
              borderRadius: BorderRadius.circular(50)),
          duration: Duration(seconds: 0),
          onEnd: () {
            //hacer algo una vez finalizado la animacion
          },
          child: Container(
            margin: EdgeInsets.all(10),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Introduce su email",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
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
                            setState(() {
                              _validatorIsActivated = true;
                            });
                            return "Please insert your email";
                          }
                          return null;
                        },
                      ),
                    ),
                    const Text(
                      "Introduce su contraseña",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
                            setState(() {
                              _validatorIsActivated = true;
                            });
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
                              //Uso el widget PageRouteBuilder para cambiar la animacion de transicion
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      HomePage(email: emailController.text),
                                  transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) =>
                                      SlideTransition(
                                    position: animation.drive(
                                      Tween(
                                          begin: Offset(1.0, 0.0),
                                          end: Offset(0.0, 0.0)),
                                    ),
                                    child: child,
                                  ),
                                ),
                              );
                              /*
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage(email: emailController.text)));
                               */
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Invalid Credentials')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill input')));
                          }
                        },
                        child: const Text("Submit"))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
