import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/enum/payment_method.dart';
import '../../../../core/enum/delivery_method.dart';
import '../../../../core/themes/text/text_styles.dart';
import '../../../../generated/l10n.dart';

class OrderMethodDisplayWidget extends StatelessWidget {
  final String title;
  final String methodText;
  final IconData icon;
  final Color? iconColor;

  const OrderMethodDisplayWidget({
    super.key,
    required this.title,
    required this.methodText,
    required this.icon,
    this.iconColor,
  });

  factory OrderMethodDisplayWidget.payment({
    required String title,
    required PaymentMethod? paymentMethod,
    required BuildContext context,
  }) {
    IconData icon;
    switch (paymentMethod) {
      case PaymentMethod.cashOnDelivery:
        icon = Icons.attach_money;
        break;
      case PaymentMethod.debitCreditCard:
        icon = Icons.credit_card;
        break;
      case PaymentMethod.debitCreditCardOnDelivery:
        icon = Icons.payments;
        break;
      default:
        icon = Icons.payment;
    }

    return OrderMethodDisplayWidget(
      title: title,
      methodText: paymentMethod?.getLocalizedDisplayName(S.of(context)) ?? 'Unknown',
      icon: icon,
      iconColor: Colors.blue,
    );
  }

  factory OrderMethodDisplayWidget.delivery({
    required String title,
    required DeliveryMethod? deliveryMethod,
    required BuildContext context,
  }) {
    IconData icon;
    switch (deliveryMethod) {
      case DeliveryMethod.homeDelivery:
        icon = Icons.home;
        break;
      case DeliveryMethod.pharmacyPickup:
        icon = Icons.local_pharmacy;
        break;
      default:
        icon = Icons.location_on;
    }

    return OrderMethodDisplayWidget(
      title: title,
      methodText: deliveryMethod?.getLocalizedDisplayName(S.of(context)) ?? 'Unknown',
      icon: icon,
      iconColor: Colors.green,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.settingsTitle.copyWith(fontSize: 15.sp),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              icon,
              color: iconColor ?? Colors.grey,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              methodText,
              style: TextStyles.orderInfoText.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
} 