
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/core/db/cart/model/product.dart';
import 'package:pharmacy/features/cart/repository/cart_repository.dart';
import 'package:pharmacy/core/common_widgets/simple_card_widget.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _cartRepository;

  CartCubit(this._cartRepository) : super(const Initial());

  void emitCartState() {
    emit(const Loading());
    _cartRepository.fetchCartItem().then((result) {
      result.when(
          success: (List<Product> data) {
            // Clear cart status cache when cart state changes
            CartStatusCache.clearCache();
            emit(Success(data));
          },
          failure: (error) => emit(Error(error)));
    });
  }

  Future<void> updateCartItem(int productId, int newQuantity) async {
    try {
      await _cartRepository.updateCartItem(productId, newQuantity);
      // Refresh cart state after update
      emitCartState();
    } catch (error) {
      emit(Error('Failed to update cart item: $error'));
    }
  }

  void addItemToCart(Product product) {
    _cartRepository.addCartItem(product).then((_) {
      // Refresh cart state after adding
      emitCartState();
    }).catchError((error) {
      emit(Error('Failed to add item to cart: $error'));
    });
  }

  void deleteCartItem(int productId) {
    _cartRepository.deleteCartItem(productId).then((_) {
      // Refresh cart state after deleting
      emitCartState();
    }).catchError((error) {
      emit(Error('Failed to delete cart item: $error'));
    });
  }
  
  void dropCartItem() {
    _cartRepository.dropCartItem().then((_) {
      // Refresh cart state after dropping
      emitCartState();
    }).catchError((error) {
      emit(Error('Failed to drop cart: $error'));
    });
  }
}
