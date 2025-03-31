import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    required String selectedUnit,
    required double price,
  }) = _ProductState;

  // Default initial state
  factory ProductState.initial() => ProductState(
    selectedUnit: 'productUnit1',
    price: 0,
  );
}