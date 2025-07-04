import 'package:flutter/material.dart';

import '../../../../core/models/order/customer/customer_order_model.dart';
import '../../../../generated/l10n.dart';

class CustomerInfoWidget extends StatelessWidget {
  final CustomerOrderModel orderInfo;

  const CustomerInfoWidget({
    super.key,
    required this.orderInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(8),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadiusDirectional.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${S.of(context).CustomerId}: ${orderInfo.id}"),
          Text("${S.of(context).CustomerName}: ${orderInfo.firstName} ${orderInfo.lastName}"),
          Text("${S.of(context).CustomerEmail}: ${orderInfo.userEmail}"),
          Text("${S.of(context).CustomerPhone}: ${orderInfo.userPhone}"),
        ],
      ),
    );
  }
}