import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/common_widgets/card_widget.dart';

import '../../../../core/models/order/customer/customer_order_model.dart';
import '../../../../core/themes/text/text_styles.dart';
import '../../../../generated/l10n.dart';
import 'order_item_widget.dart';

class OrderInfoWidget extends StatelessWidget {
  final CustomerOrderModel orderInfo;

  const OrderInfoWidget({
    super.key,
    required this.orderInfo,
  });

  @override
  Widget build(BuildContext context) {
    if (orderInfo.items == null || orderInfo.items!.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: const Text('No items in this order'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).orderDetails,
            style: TextStyles.settingsTitle.copyWith(fontSize: 15.sp)),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: orderInfo.items!.length,
          itemBuilder: (context, index) {
            final orderItemInfo = orderInfo.items![index];
            return OrderItemWidget(
              orderItemInfo: orderItemInfo,
            );
          },
        ),
      ],
    );
  }
}
