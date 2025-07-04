import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';

class PaymentOption {
  final String Function(BuildContext) labelBuilder;
  final IconData icon;

  PaymentOption({required this.labelBuilder, required this.icon});
}

List<PaymentOption> getPaymentOptions(BuildContext context) => [
  PaymentOption(labelBuilder: (ctx) => S.of(ctx).cashOnDelivery, icon: Icons.attach_money),
  PaymentOption(labelBuilder: (ctx) => S.of(ctx).debitCreditCard, icon: Icons.credit_card),
  PaymentOption(labelBuilder: (ctx) => S.of(ctx).debitCreditCardUponReceipt, icon: Icons.payments),
]; 