import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharedPreferences',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

const String _prefCounter = 'counter';
const String _prefNotificationsEnabled = 'notifications_enabled';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Preferences Example"),
      ),
      body: Center(
        child:
            _selectedIndex == 0 ? const CounterScreen() : const ConfigScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          setState(
            () {
              _selectedIndex = index;
            },
          );
        },
      ),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  _incrementCounter() async {
    setState(() {
      _counter++;
    });
    //guardo el valor de la variable contador en _prefCounter
    SharedPreferences.getInstance()
        .then((value) => value.setInt(_prefCounter, _counter));
  }

//
/* getCounterValue devuelve un Future con el valor del contador.
   El future se usa para indicar que la funcion puede tardar un tiempo en completarse,
     ya que necesita obtener el valor del contador de Shared Preferences */
  Future<int> getCounterValue() async {
    return SharedPreferences.getInstance()
        .then((prefs) => prefs.getInt(_prefCounter) ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    // Usamos el widget FutureBuilder, para mostrar datos de un Future, toma dos parametros el future y el widget builder.
    return FutureBuilder(
      //el widget builder se llama cuando el Future se completa, el builder recibe un AsyncSnapshot como parametro,
      //AsyncSnapshot contiene el estado del Future y los datos del Future (si el Future se ha completado)
      future: getCounterValue(),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        //si los datos todavia no se cargaron muestro un CircularProgressIndicator
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        //asigno el valor que obtengo del Future al contador interno
        _counter = snapshot.data!;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: () {
                _incrementCounter();
              },
              child: const Text("Aumentar"),
            ),
          ],
        );
      },
    );
  }
}

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

Future<bool> getNotificationsSetting() async {
  return SharedPreferences.getInstance()
      .then((prefs) => prefs.getBool(_prefNotificationsEnabled) ?? false);
}

class _ConfigScreenState extends State<ConfigScreen> {
  bool _isCheked = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getNotificationsSetting(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          _isCheked = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Activar Notifiaciones",
                      style: TextStyle(fontSize: 18),
                    ),
                    Checkbox(
                        checkColor: Colors.white70,
                        value: _isCheked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isCheked = value!;
                          });
                          //llamo a la funcion para guardar el valor
                          saveNotificationSettings(_isCheked);
                        })
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text("La app notificara de nuevos mensajes"),
              )
            ],
          );
        });
  }

//Guardo el nuevo valor de isChecked
  void saveNotificationSettings(bool isCheked) async {
    SharedPreferences.getInstance()
        .then((prefs) => prefs.setBool(_prefNotificationsEnabled, isCheked));
  }
}
