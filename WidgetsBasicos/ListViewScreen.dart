import 'package:flutter/material.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List View'),
      ),
      body: ListViewTappable(),
    );
  }
}

class ListViewWidgets extends StatelessWidget {
  const ListViewWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 60,
          color: Colors.amber,
          child: const Center(child: Text('FILA A')),
        ),
        Container(
          height: 50,
          color: Colors.redAccent,
          child: const Center(child: Text('FILA B')),
        ),
        Container(
          height: 50,
          color: Colors.green,
          child: const Center(child: Text('FILA C')),
        ),
        Container(
          height: 50,
          color: Colors.blueAccent,
          child: const Center(child: Text('FILA D')),
        )
      ],
    );
  }
}

class ListViewWithBuilder extends StatelessWidget {
  /*
  Estas listas son representaciones, donde pueden ser listas que vengan de un servidor
  o desde otra fuente, la cual no sabemos cuantas listas nos puede llegar a venir
   */
  final List<String> rows = <String>['A', 'B', 'C', 'D'];
  final List<int> colorCodes = <int>[600, 500, 100, 900];

  ListViewWithBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Usamos el ListView con el metodo builder al cual hay que pasarle un itemBuilder
    return ListView.builder(
        //Al builder hay que decirle la cantidad de elementos que vamos a tener
        itemCount: rows.length,
        /*
        Al itemBuilder hay que pasarle un context y un index que representa
        la posicion en la lista
         */
        itemBuilder: (context, index) {
          //Dentro de este metodo se va a llamar cada vez que se quiera dibujar una de las filas
          return Container(
            height: 50,
            color: Colors.amber[colorCodes[index]],
            child: Center(child: Text('Fila ${rows[index]}')),
          );
        });
  }
}

class ListViewWithSeparator extends StatelessWidget {
  final List<String> rows = <String>['A', 'B', 'C', 'D'];
  /*
  colorCodes es una lista de cuatro numeros enterons. Los numeros enteros
  representan los valroes de los colores en la escala de colores HSL(Tono,Saturacion y Luminosidad)
   */
  final List<int> colorCodes = <int>[600, 500, 100, 900];

  ListViewWithSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //En este caso los elementos de la lista se separan por un separador.
    return ListView.separated(
      //Recibe lo mismos parametros que el anterior pero se agrega uno mas
      itemCount: rows.length,
      itemBuilder: (context, index) {
        return Container(
          height: 50,
          color: Colors.amber[colorCodes[index]],
          child: Center(child: Text('Fila ${rows[index]}')),
        );
      },
      //Esta funcion se usa para crear los separadores de la lista
      separatorBuilder: (context, index) {
        //Se puede acceder a los indeces de los elementos
        if (index == 0) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: const Text("Elementos nuevos"),
          );
        }
        var height = 10.0;
        if (index == 2) {
          height = 30.0;
        }
        return Divider(
          height: height,
        );
      },
    );
  }
}

class ListViewTappable extends StatelessWidget {
  final List<String> rows = <String>['A', 'B', 'C', 'D'];
  final List<int> colorCodes = <int>[600, 500, 100, 900];

  ListViewTappable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, index) {
          /*
          Es parecido al gestureDetector pero incluye un feedback, se genera una animacion
          que se muestra, puede ser cualquier animacion como un resaltado, una sombra, o una animacion de desplazamiento
           */
          return InkWell(
            onTap: () {
              //Aca definimos que tiene hacer cuando se presiona
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Apretaste Fila ${rows[index]}")));
            },
            //Aca definimos las animaciones que va a realizar
            //splashColor: Colors.blue,
            //splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
            highlightColor: Colors.blueAccent,

            /*
            Usamos un ListTile es un widget que nos ayuda a definir e implementar
            elementos a una lista
             */
            child: ListTile(
              title: Center(child: Text('Fila ${rows[index]}')),
              tileColor: Colors.amber[colorCodes[index]],
            ),
          );
        });
  }
}
