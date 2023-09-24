import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models.dart';

class ShopDatabase {
  //Metodo singleton
  static final ShopDatabase instance = ShopDatabase._init();
  //Creo una instancia de una base de datos
  static Database? _database;

  ShopDatabase._init();

  final String tableCartItems = 'cart_items';
  //creo un metodo para obtener la base datos
  Future<Database> get database async {
    //si la base de datos no es nula es decir ya esta creada retorno la base de datos
    if (_database != null) {
      return _database!;
    }
    //si la base de datos es nula, creo la base datos
    _database = await _initDB('shop.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    //Obtengo el path la base de datos
    final dbPath = await getDatabasesPath();
    //uno el path con el nombre de la base de datos
    final path = join(dbPath, filePath);
    /* llamo a openDatabase y tiene los siguientes parámetros:
    path: La ruta a la base de datos.
    version: La versión de la base de datos.
    onCreate: Un callback que se ejecuta cuando se crea la base de datos por primera vez.
    onUpgrade: Un callback que se ejecuta cuando se actualiza la base de datos a una nueva versión.
    onDowngrade: Un callback que se ejecuta cuando se degrada la base de datos a una versión anterior.
    El método openDatabase() devuelve un Future con la base de datos abierta.
    */
    return await openDatabase(path,
        version: 1,
        onCreate: _onCreateDB); //Creamos la base de datos si no existe
  }

  //metodo para crear la tabla en la base datos
  Future _onCreateDB(Database db, int version) async {
    // utilizo comillas triples para escribir enters
    await db.execute('''
    CREATE TABLE $tableCartItems(
    id INTEGER PRIMARY KEY,
    name TEXT,
    price INTEGER,
    quantity INTEGER 
    )
    ''');
  }

  Future<void> insert(CartItem item) async {
    final db = await instance.database;
    /*El método insert() tiene los siguientes parámetros:
      table: El nombre de la tabla en la que se insertará la nueva fila.
      data: Los datos que se insertarán en la nueva fila. Los datos deben estar en forma de map,
          donde las claves son los nombres de las columnas y los valores son los datos que se insertarán en las columnas.
      conflictAlgorithm: El algoritmo que se utilizará para resolver conflictos si se inserta una nueva fila
          con el mismo valor de la clave principal que una fila existente.
     */
    await db.insert(tableCartItems, item.toMap(),
        //si encuentra un item del mismo id lo reemplaza
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Funcion para obtener todos los items de la base de datos
  Future<List<CartItem>> getAllItems() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableCartItems);

    return List.generate(maps.length, (i) {
      return CartItem(
        id: maps[i]['id'],
        name: maps[i]['name'],
        price: maps[i]['price'],
        quantity: maps[i]['quantity'],
      );
    });
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    /* el método delete() de la biblioteca sqflite se utiliza para eliminar
     una fila de una tabla de una base de datos SQLite.
     */
    return await db.delete(
      tableCartItems,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteAll() async {
    final db = await instance.database;
    final rowsDeleted = await db.delete('items');
  }

  Future<int> update(CartItem item) async {
    final db = await instance.database;
    return await db.update(
      tableCartItems,
      item.toMap(),
      where: "id=?",
      whereArgs: [item.id],
    );
  }
}
