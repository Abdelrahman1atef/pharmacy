import 'package:json_annotation/json_annotation.dart';
import 'package:pharmacy/generated/l10n.dart';

enum PaymentMethod {
  @JsonValue('cash_on_delivery')
  cashOnDelivery,
  
  @JsonValue('debit_credit_card')
  debitCreditCard,
  
  @JsonValue('debit_credit_card_on_delivery')
  debitCreditCardOnDelivery,
}

extension PaymentMethodExtension on PaymentMethod {
  String get displayName {
    switch (this) {
      case PaymentMethod.cashOnDelivery:
        return 'cash_on_delivery';
      case PaymentMethod.debitCreditCard:
        return 'debit_credit_card';
      case PaymentMethod.debitCreditCardOnDelivery:
        return 'debit_credit_card_on_delivery';
    }
  }
  
  String getLocalizedDisplayName(S s) {
    switch (this) {
      case PaymentMethod.cashOnDelivery:
        return s.cashOnDelivery;
      case PaymentMethod.debitCreditCard:
        return s.debitCreditCard;
      case PaymentMethod.debitCreditCardOnDelivery:
        return s.debitCreditCardUponReceipt;
    }
  }
  
  bool get isCashOnDelivery => this == PaymentMethod.cashOnDelivery;
  bool get isDebitCreditCard => this == PaymentMethod.debitCreditCard;
  bool get isDebitCreditCardOnDelivery => this == PaymentMethod.debitCreditCardOnDelivery;
} 