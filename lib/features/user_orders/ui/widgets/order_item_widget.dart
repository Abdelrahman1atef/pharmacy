import 'package:flutter/material.dart';

import '../../../../core/models/order/customer/customer_order_item_model.dart';
import '../../../../core/themes/text/text_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/network_image_utils.dart';

class OrderItemWidget extends StatelessWidget {
  final CustomerOrderItemModel orderItemInfo;

  const OrderItemWidget({super.key, required this.orderItemInfo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      contentPadding: const EdgeInsetsDirectional.all(0),
      leading: Image.network(
        (orderItemInfo.productImages != null &&
            orderItemInfo.productImages!.isNotEmpty)
            ? orderItemInfo.productImages!.first
            : "", // Or use a default image URL here
        fit: BoxFit.cover,
        loadingBuilder: loadingBuilder(),
        errorBuilder: errorBuilder(Assets.images.pWatermarkV2.path),
      ),
      title: Text(
        orderItemInfo.nameAr,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.productHomeTitles,
      ),
      subtitle: Text("${orderItemInfo.unitType} ${orderItemInfo.unitPrice} ×${orderItemInfo.quantity}"),
      trailing: Text("${orderItemInfo.itemTotal} ${S.of(context).pound}",
          style: TextStyles.cartProductPrice),
    );
  }
}