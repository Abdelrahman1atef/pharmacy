
import 'package:pharmacy/features/cart/data/model/product.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/db/db_helper.dart';
import 'cart_table_constants.dart';

class CartCrud {
  //1- single instance
  CartCrud._();

  static final CartCrud crud = CartCrud._();

//2-Create
  Future<void> create(Product product) async {
    Database db = await DbHelper.helper.getDbInstance();

    // Check if product already exists
    final existingProduct = await db.query(
      tableName,
      where: 'productId = ?',
      whereArgs: [product.productId],
    );

    if (existingProduct.isNotEmpty) {
      // If exists, update quantity
      await db.update(
        tableName,
        {'quantity': product.quantity},
        where: 'productId = ?',
        whereArgs: [product.productId],
      );
    } else {
      // Otherwise, insert new product
      await db.insert(tableName, product.toJson());
    }
  }

//3-Read
  Future<List<Product>> read() async {
    Database db = await DbHelper.helper.getDbInstance();
    final List<Map<String, dynamic>> results = await db.query(tableName);
    return results.map((e) => Product.fromJson(e)).toList();

    // return List.generate(maps.length, (i) {
    //   return Product(
    //     productId: maps[i]['productId'],
    //     productNameEn: maps[i]['productNameEn'],
    //     sellPrice: maps[i]['sellPrice'],
    //     productImageUrl: maps[i]['productImageUrl'],
    //     quantity: maps[i]['quantity'],
    //   );
    // });
  }

//############################
// //4-Update
//   Future<int> Update(Product product) async{
//     Database db = await DbHelper.helper.getDbInstance();
//
//     return await db.update(tableName, product.toMap(),where: '$colId=?',whereArgs: [product.productId]);
//   }

//5-Delete
  Future<void> delete(int productId) async {
    Database db = await DbHelper.helper.getDbInstance();
    await db.delete(tableName, where: 'productId = ?', whereArgs: [productId]);
  }

  //6-Drop
  Future<void> clearCart() async {
    final db = await DbHelper.helper.getDbInstance();
    await db.delete(tableName);
  }
}
