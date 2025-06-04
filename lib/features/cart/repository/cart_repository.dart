import 'package:pharmacy/core/db/cart/cart_crud.dart';

import '../../../core/db/cart/model/product.dart';
import '../../../core/db/dbHelper/db_result.dart';

class CartRepository {
  final CartCrud cartCrud;

  CartRepository(this.cartCrud);
  
  Future<DBResult<List<Product>>> fetchCartItem()async{
    try {
      return await cartCrud.read();
    } catch (e) {
      print('Error fetching cart items: $e');
      rethrow; // Rethrow the error to propagate it to the caller
    }
  }
  Future<Product?> fetchProductById(int productId)async{
    try {
      return await cartCrud.fetchProductById(productId);
    } catch (e) {
      print('Error fetching cart items: $e');
      rethrow; // Rethrow the error to propagate it to the caller
    }
  }
  Future<int> updateCartItem(int productId, int newQuantity) async {
    try {
      print("productId: $productId newQuantity:$newQuantity");
      return await cartCrud.update(productId,newQuantity);
    } catch (e) {
      print('Error updating cart items: $e');
      rethrow; // Rethrow the error to propagate it to the caller
    }
  }
  Future <void> addCartItem(Product product )async{
    try {
      return await cartCrud.create(product);
    } catch (e) {
      print('Error adding cart items: $e');
      rethrow; // Rethrow the error to propagate it to the caller
    }
  }
  Future<void> deleteCartItem(int productId) async {
    try {
      return await cartCrud.delete(productId);
    } catch (e) {
      print('Error deleting cart items: $e');
      rethrow; // Rethrow the error to propagate it to the caller
    }
  }
  Future<void> dropCartItem() async {
    try {
      return await cartCrud.clearCart();
    } catch (e) {
      print('Error deleting cart items: $e');
      rethrow; // Rethrow the error to propagate it to the caller
    }
  }

}