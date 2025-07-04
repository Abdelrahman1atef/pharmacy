import 'package:bloc/bloc.dart';
import 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(const PaymentState());

  void selectPayment(int index) {
    emit(state.copyWith(selectedPaymentIndex: index));
  }
} 