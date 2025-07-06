import '../../../../core/enum/delivery_method.dart';

class CheckoutState {
  final bool isHomeDeliverySelected;
  final bool isCallRequestEnabled;
  final String? promoCode;
  final DateTime? selectedDateTime;
  final DateTime? slotEndDateTime;

  CheckoutState({
    required this.isHomeDeliverySelected,
    this.isCallRequestEnabled = false,
    this.promoCode,
    DateTime? selectedDateTime,
    DateTime? slotEndDateTime,
  })  : selectedDateTime = selectedDateTime ?? _defaultSelectedDateTime(),
        slotEndDateTime = slotEndDateTime ?? _defaultSlotEndDateTime(selectedDateTime ?? _defaultSelectedDateTime());

  static DateTime _defaultSelectedDateTime() {
    final now = DateTime.now();
    // Round up to the next half hour
    int minute = now.minute < 30 ? 30 : 0;
    int hour = now.minute < 30 ? now.hour : now.hour + 1;
    DateTime nextHalfHour = DateTime(now.year, now.month, now.day, hour, minute);
    // Add a 30-minute buffer
    DateTime start = nextHalfHour.add(const Duration(minutes: 30));
    return start;
  }

  static DateTime _defaultSlotEndDateTime(DateTime start) {
    return start.add(const Duration(hours: 2));
  }

  CheckoutState copyWith({
    bool? isHomeDeliverySelected,
    bool? isCallRequestEnabled,
    String? promoCode,
    DateTime? selectedDateTime,
    DateTime? slotEndDateTime,
  }) {
    final newSelectedDateTime = selectedDateTime ?? this.selectedDateTime;
    return CheckoutState(
      isHomeDeliverySelected: isHomeDeliverySelected ?? this.isHomeDeliverySelected,
      isCallRequestEnabled: isCallRequestEnabled ?? this.isCallRequestEnabled,
      promoCode: promoCode ?? this.promoCode,
      selectedDateTime: newSelectedDateTime,
      slotEndDateTime: slotEndDateTime ?? _defaultSlotEndDateTime(newSelectedDateTime!),
    );
  }

  // Helper getter for delivery method
  DeliveryMethod get deliveryMethod => isHomeDeliverySelected ? DeliveryMethod.homeDelivery : DeliveryMethod.pharmacyPickup;
}