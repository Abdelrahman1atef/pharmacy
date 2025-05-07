import 'package:flutter_bloc/flutter_bloc.dart';

class QuantitySelectorCubit extends Cubit<int> {
  QuantitySelectorCubit(super.initialQuantity);

  void increment() => emit(state + 1);

  void decrement() {
    if (state > 0) emit(state - 1);
  }

  void setQuantity(int value) => emit(value);
}
