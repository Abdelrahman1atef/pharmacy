import 'dart:convert';

import 'package:pharmacy/core/db/dbHelper/db_result.dart';
import 'package:sqflite/sqflite.dart';
import '../dbHelper/db_helper.dart';
import 'cart_table_constants.dart';
import 'model/product.dart';

class CartCrud {
  //1- single instance
  final DbHelper dbHelper;

  CartCrud(this.dbHelper);

//2-Create
  Future<void> create(Product product) async {
    Database db = await dbHelper.getDbInstance();

    if (await isItemInCart(product.productId)) {
      // If exists, update quantity
      await db.update(
        tableName,
        {colQuantity: product.quantity},
        where: '$colProductId = ?',
        whereArgs: [product.productId],
      );
    } else {
      // Otherwise, insert new product
      final data = product.toJson();

      // ⚠️ Convert List<String> to JSON string before inserting
      data['product_images'] = jsonEncode(product.productImages);

      await db.insert(
        tableName,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

//3-Read
  Future<DBResult<List<Product>>> read() async {
    Database db = await dbHelper.getDbInstance();
    final List<Map<String, dynamic>> results = await db.query(tableName);

    final List<Product> cartResult = results.map((e) {
      final fixedMap = Map<String, dynamic>.from(e);

      // Decode the product_images JSON string back to List<String>
      if (fixedMap['product_images'] != null) {
        fixedMap['product_images'] =
            jsonDecode(fixedMap['product_images'])?.cast<String>();
      }

      return Product.fromJson(fixedMap);
    }).toList();

    return DBResult<List<Product>>.success(cartResult);
  }

  Future<Product?> fetchProductById(int productId) async {
    Database db = await dbHelper.getDbInstance();
    final result = await db.query(
      tableName,
      where: '$colProductId = ?',
      whereArgs: [productId],
    );
    if (result.isNotEmpty) {
      return Product.fromJson(result.first); // Convert the first result to a Product object
    }
    return null; // Return null if no product is found
  }

//4-Update
  Future<int> update(int productId, int newQuantity) async {
    Database db = await dbHelper.getDbInstance();
    return await db.update(tableName,
        {colQuantity: newQuantity},
        where: '$colProductId=?', whereArgs: [productId]);
  }

  //5-Delete
  Future<void> delete(int productId) async {
    Database db = await dbHelper.getDbInstance();
    await db.delete(tableName, where: '$colProductId = ?', whereArgs: [productId]);
  }

  //6-Drop
  Future<void> clearCart() async {
    final db = await dbHelper.getDbInstance();
    await db.delete(tableName);
  }

  Future<bool> isItemInCart(int productId) async {
    final db = await dbHelper.getDbInstance();
    final result = await db.query(
      tableName,
      where: '$colProductId = ?',
      whereArgs: [productId],
    );
    return result.isNotEmpty;
  }
}
