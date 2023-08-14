import 'package:flutter/material.dart';

/*Imagenes soportadas:
jpeg, png, GIF, animated GIF, WebP, Animated WebP, BMP, and WBMP
 */
class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Imagenes',
        ),
      ),
      body: ImagesList(),
    );
  }
}

class ImagesList extends StatelessWidget {
  const ImagesList({super.key});

  @override
  Widget build(BuildContext context) {
    //SingleChildScrollView para scrolear hacia abajo o arriba para ver el contenido
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
              child: Column(
            children: [
              Image.network(
                'https://images.pexels.com/photos/7149465/pexels-photo-7149465.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                //uso loadingBuilder se usa para mostrar un widget cuando la imagen esta cargando
                loadingBuilder: (context, child, loadingProgres) {
                  //si el loadingProgress es null significa que aun no cargo la imagen
                  //por lo que el widget loadingBuilder devolvera el widget child que es la imagen
                  if (loadingProgres == null) return child;
                  //si el widget loadingProgres no es null significa qu la imagen ha comenzado a cargarse porlo que
                  //el widget loadingBuilder devolvera un widget cnter con un widget CicularProgessIndicator
                  return Center(
                    //es un widget para mostrar un indicador de progreso circular
                    //El valor del indicador de progreso circular se basa en el numero de bytes que se han cargado
                    //y el numero total de bytes que se espera que carguen
                    child: CircularProgressIndicator(
                      value: loadingProgres.expectedTotalBytes != null
                          ? loadingProgres.cumulativeBytesLoaded /
                              loadingProgres.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
              Text('Este es un gatito',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700))
            ],
          )),
          Card(
            child: Column(
              children: [
                Image.asset(
                  'Imagenes/imagen1.jpg',
                  fit: BoxFit.fill,
                ),
                Text('Este soy yo de uniforme',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700))
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                Image.asset(
                  'Imagenes/imagen2.jpg',
                  fit: BoxFit.fill,
                ),
                Text('Este soy yo en el gym',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700))
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                Image.asset(
                  'Imagenes/imagen3.jpg',
                  fit: BoxFit.fill,
                ),
                Text('Salio selfie',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700))
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                Image.asset(
                  'Imagenes/imagen4.jpg',
                  fit: BoxFit.fill,
                ),
                Text('Salio selfie en la cuarentena',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700))
              ],
            ),
          )
        ],
      ),
    );
  }
}
