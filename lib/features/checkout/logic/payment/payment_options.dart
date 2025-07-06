import 'package:flutter/material.dart';
import '../../../../core/enum/payment_method.dart';
import '../../../../generated/l10n.dart';

class PaymentOption {
  final PaymentMethod method;
  final IconData icon;

  PaymentOption({required this.method, required this.icon});
  
  String getLocalizedLabel(S s) {
    return method.getLocalizedDisplayName(s);
  }
}

List<PaymentOption> getPaymentOptions() => [
  PaymentOption(method: PaymentMethod.cashOnDelivery, icon: Icons.attach_money),
  PaymentOption(method: PaymentMethod.debitCreditCard, icon: Icons.credit_card),
  PaymentOption(method: PaymentMethod.debitCreditCardOnDelivery, icon: Icons.payments),
]; 