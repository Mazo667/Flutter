import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite/models.dart';
import 'package:sqlite/notifier.dart';
import 'package:sqlite/shop_database.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //El Consumer se usa para escuchar los cambios de un ChangeNotifier y reconstruir el widget cuando los datos cambian.
    return Consumer<CartNotifier>(
      //el builder se llama cuando ChangeNotifier cambia y recibe como parametro una instancia de ChangeNotifier
      builder: (context, cart, child) {
        //Uso FutureBuilder para obtener un future, que en este caso es todos los items de la base de datos
        return FutureBuilder(
            future: ShopDatabase.instance.getAllItems(),
            builder:
                //el widget builder se llama cuando el Future se completa
                //AsyncSnapshot contiene el estado del Future y los datos del Future (si el Future se ha completado)
                (BuildContext context, AsyncSnapshot<List<CartItem>> snapshot) {
              if (snapshot.hasData) {
                List<CartItem> cartItems = snapshot.data!;
                //preguntamos si el carro esta vacio
                return cartItems.isEmpty
                    ? const Center(
                        child: Text(
                          "No hay productos en tu carro",
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    //si tiene items hacemos un ListView
                    : ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              color: Colors.black26,
                              child: _CartItem(cartItems[index]));
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                              height: 2,
                            ),
                        itemCount: cartItems.length);
              } else {
                return const Center(
                  child: Text(
                    "No hay productos en tu carro",
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }
            });
      },
    );
  }
}

class _CartItem extends StatelessWidget {
  final CartItem cartItem;
  const _CartItem(this.cartItem);
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: TextStyle(
          fontSize: 15, color: Colors.white70, fontWeight: FontWeight.bold),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              Icons.laptop,
              size: 80,
            ),
            //Image.asset('assets/images/laptop'),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(cartItem.name),
                  Text("\$" + cartItem.price.toString()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(cartItem.quantity.toString() + " unidades"),
                      IconButton.filled(
                        icon: Icon(
                          Icons.add,
                        ),
                        style:
                            IconButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: () async {
                          cartItem.quantity++;
                          await ShopDatabase.instance.update(cartItem);
                          Provider.of<CartNotifier>(context, listen: false)
                              .shouldRefresh();
                        },
                      ),
                      IconButton.filled(
                        icon: Icon(Icons.remove),
                        style: IconButton.styleFrom(
                            backgroundColor: Colors.redAccent),
                        onPressed: () async {
                          cartItem.quantity--;
                          if (cartItem.quantity == 0) {
                            await ShopDatabase.instance.delete(cartItem.id);
                          } else {
                            await ShopDatabase.instance.update(cartItem);
                          }
                          //Llamo al provider para que notifique a todos los listeners que hubo un cambio
                          Provider.of<CartNotifier>(context, listen: false)
                              .shouldRefresh();
                        },
                      )
                    ],
                  ),
                  Text("Total: \$" + cartItem.totalPrice.toString()),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent),
                      onPressed: () async {
                        await ShopDatabase.instance.delete(cartItem.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Producto eliminado!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                        Provider.of<CartNotifier>(context, listen: false)
                            .shouldRefresh();
                      },
                      child: const Text("Eliminar"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
