import 'package:bloc/bloc.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit()
      : super(CheckoutState(
    isHomeDeliverySelected: true, // Default to home delivery
  ));

  void setDeliveryMethod(bool isHomeDelivery) {
    emit(state.copyWith(
      isHomeDeliverySelected: isHomeDelivery,
    ));
  }

  void setCallRequestEnabled(bool isEnabled) {
    emit(state.copyWith(
      isCallRequestEnabled: isEnabled,
    ));
  }

  void setPromoCode(String? code) {
    emit(state.copyWith(
      promoCode: code,
    ));
  }

  void setPreSelectedDateTime(DateTime? dateTime) {
    emit(state.copyWith(
      selectedDateTime: dateTime,
    ));
  }
  void setSelectedDateTime(DateTime? dateTime) {
    emit(state.copyWith(
      selectedDateTime: dateTime,
    ));
  }

  // Helper methods
  bool get isHomeDelivery => state.isHomeDeliverySelected;
  bool get isPharmacyPickup => !state.isHomeDeliverySelected;
  bool get isCallRequestEnabled => !state.isCallRequestEnabled;
  String get deliveryMethod => state.deliveryMethod;
  DateTime? get selectedDateTime => state.selectedDateTime;
}