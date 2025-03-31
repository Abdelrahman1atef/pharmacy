import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/features/details/logic/product/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductState.initial());

  void selectUnit(String unit, double price) {
    emit(state.copyWith(selectedUnit: unit, price: price));
  }
}