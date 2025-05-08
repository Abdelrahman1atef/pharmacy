

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/core/db/cart/model/product.dart';
import 'package:pharmacy/features/cart/repository/cart_repository.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _cartRepository;
  CartCubit(this._cartRepository) : super(const Initial());

  void emitCartState() {
    emit(const Loading());
    _cartRepository.fetchCartItem().then((result) {
      result.when(
          success: (List<Product> data) => emit(Success(data)),
          failure: (error) => emit(Error(error)));
    });
  }
  Future<void> updateCartItem(int productId, int newQuantity) async {
    try {
      await _cartRepository.updateCartItem(productId, newQuantity);

      final updatedProduct = await _cartRepository.fetchProductById(productId);
      if (updatedProduct == null) throw Exception("Product not found");

      // Only update the single product in current state
      final currentState = state;
      if (currentState is Success) {
        final updatedList = List<Product>.from(currentState.data);
        final index = updatedList.indexWhere((p) => p.productId == productId);

        if (index != -1) {
          updatedList[index] = updatedProduct;
          emit(Success(updatedList));
        }
      }
    } catch (error) {
      emit(Error('Failed to update cart item: $error'));
    }
  }
  void addItemToCart(Product product) {
    // Emit loading state while adding the item
    _cartRepository.addCartItem(product).then((_) {
      // After adding, fetch the updated cart items
      emitCartState();
    }).catchError((error) {
      // Handle errors during the add operation
      emit(Error('Failed to add item to cart: $error'));
    });
  }
  void deleteCartItem(int productId){
    _cartRepository.deleteCartItem(productId).then((_) {
      // After adding, fetch the updated cart items
      emitCartState();
    }).catchError((error) {
      // Handle errors during the add operation
      emit(Error('Failed to add item to cart: $error'));
    });
  }

}
