import 'package:flutter/material.dart';
import 'package:sqlite/models.dart';
import 'package:sqlite/shop_database.dart';

class ProductList extends StatelessWidget {
  var products = [
    Product(1, 'laptop', 'Dell Vostro', 300000),
    Product(2, 'laptop', 'Lenovo ', 552000),
    Product(3, 'laptop', 'HP Pavillion', 279000),
  ];

  ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Card(
                color: Colors.white70, child: _ProductItem(products[index])),
            onTap: () async {
              //Llamo al metodo addToCart y le paso el producto
              await addToCart(products[index]);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Producto Agregado"),
                duration: Duration(seconds: 2),
              ));
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1,
          );
        },
        itemCount: products.length);
  }

  Future<void> addToCart(Product product) async {
    //Convierto el producto en un CartItem
    final item = CartItem(
        id: product.id, name: product.name, price: product.price, quantity: 1);
    //el CartItem creado lo agrego a la base de datos con el metodo insert
    await ShopDatabase.instance.insert(item);
  }
}

class _ProductItem extends StatelessWidget {
  final Product product;
  const _ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Icon(
            Icons.laptop,
            size: 80,
          ),
          //Image.asset('assets/images/laptop'),
          Padding(
            padding: const EdgeInsets.only(right: 3, left: 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name),
                Text(product.description),
                Text("\$${product.price}"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
