import '../../../../core/enum/payment_method.dart';

class PaymentHelper {
  static PaymentMethod? getPaymentMethodFromIndex(int index) {
    switch (index) {
      case 0:
        return PaymentMethod.cashOnDelivery;
      case 1:
        return PaymentMethod.debitCreditCard;
      case 2:
        return PaymentMethod.debitCreditCardOnDelivery;
      default:
        return null;
    }
  }

  static int getIndexFromPaymentMethod(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cashOnDelivery:
        return 0;
      case PaymentMethod.debitCreditCard:
        return 1;
      case PaymentMethod.debitCreditCardOnDelivery:
        return 2;
    }
  }

  static List<PaymentMethod> getAllPaymentMethods() => [
    PaymentMethod.cashOnDelivery,
    PaymentMethod.debitCreditCard,
    PaymentMethod.debitCreditCardOnDelivery,
  ];
} 