class CheckoutState {
  final bool isHomeDeliverySelected;
  final bool isCallRequestEnabled;
  final String? promoCode;

  CheckoutState({
    required this.isHomeDeliverySelected,
    this.isCallRequestEnabled = false,
    this.promoCode,
  });

  CheckoutState copyWith({
    bool? isHomeDeliverySelected,
    bool? isCallRequestEnabled,
    String? promoCode,
  }) {
    return CheckoutState(
      isHomeDeliverySelected: isHomeDeliverySelected ?? this.isHomeDeliverySelected,
      isCallRequestEnabled: isCallRequestEnabled ?? this.isCallRequestEnabled,
      promoCode: promoCode ?? this.promoCode,
    );
  }

  // Helper getter for delivery method
  String get deliveryMethod => isHomeDeliverySelected ? 'home_delivery' : 'pharmacy_pickup';
}