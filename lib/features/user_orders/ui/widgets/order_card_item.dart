import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/common_widgets/gradient_button.dart';
import 'package:pharmacy/features/user_orders/ui/widgets/order_item_widget.dart';
import 'package:pharmacy/features/user_orders/ui/widgets/reorder_helper.dart';
import 'package:pharmacy/features/user_orders/ui/widgets/simple_order_status_indicator.dart';

import '../../../../core/models/order/customer/customer_order_model.dart';
import '../../../../core/themes/text/text_styles.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../generated/l10n.dart';
import 'order_details_dialog.dart';

class OrderCardItem extends StatelessWidget {
  final CustomerOrderModel orderInfo;

  const OrderCardItem({
    super.key,
    required this.orderInfo,
  });

  @override
  Widget build(BuildContext context) {
    int orderItemNum = orderInfo.items?.length ?? 0;
    const widgetPaddingHorizontal = 8.0;
    const widgetPaddingVertical = 6.0;
    const widgetBorderRadius = 12.0;
    final orderItemInfo = orderInfo.items;
    return InkWell(
      onTap: () => OrderDetailsDialog.show(context, orderInfo),
      child: Card(
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(widgetBorderRadius)),
        elevation: 5,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsetsDirectional.symmetric(
                  vertical: widgetPaddingVertical,
                  horizontal: widgetPaddingHorizontal),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("#${orderInfo.id}"),
                          Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 5),
                            child: Text(
                              orderInfo.getDeliveryMethodText(context),
                              style: TextStyles.orderInfoText.copyWith(
                                fontSize: 15.sp
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            S.of(context).details,
                            style: TextStyles.showAllText,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: ColorName.secondaryColor,
                          )
                        ],
                      ),
                    ],
                  ),

                  // const SizedBox(height: 16),
                  // CompactOrderProgressIndicator(currentStatus: orderInfo.status,),
                  const SizedBox(height: 16),
                  OrderProgressIndicator(
                    currentStatus: orderInfo.status,
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: widgetPaddingHorizontal),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: ColorName.whiteColor,
                borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(widgetBorderRadius),
                  bottomEnd: Radius.circular(widgetBorderRadius),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: orderItemNum,
                    itemBuilder: (context, index) =>
                        OrderItemWidget(orderItemInfo: orderItemInfo![index]),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).total),
                      Text("${orderInfo.totalPrice}${S.of(context).pound}",
                          style: TextStyles.cartProductPrice),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 8, horizontal: 100),
                    child: GradientElevatedButton(
                        onPressed: () =>ReorderHelper.showReorderOptions(context, orderInfo),
                          // final authState = context.read<AuthCubit>().state;
                          //
                          // if (authState is! AuthAuthenticated) {
                          //   Navigator.pushNamed(context, Routes.login);
                          //   return;
                          // }
                          //
                          // final user = authState.user;
                          // if (orderItemInfo != null) {
                          //   final orderRequest = OrderRequest(
                          //     userId: user.id,
                          //     products: orderItemInfo,
                          //     address: orderInfo.addressName ?? "No address selected",
                          //     addressName: orderInfo.addressName ?? "No address selected",
                          //     addressStreet: orderInfo.addressStreet ?? "No street selected",
                          //     latitude: orderInfo.latitude ?? 0.0,
                          //     longitude: orderInfo.longitude ?? 0.0,
                          //     paymentMethod: orderInfo.paymentMethod,
                          //     deliveryMethod: orderInfo.deliveryMethod ?? DeliveryMethod.homeDelivery,
                          //     isHomeDelivery: orderInfo.isHomeDelivery ?? true,
                          //     callRequestEnabled: orderInfo.callRequestEnabled ?? false,
                          //     promoCode: orderInfo.promoCode,
                          //   );
                          //   context.read<OrderCubit>().createOrder(orderRequest);
                          // }
                        child: Text(
                          S.of(context).reorder,
                          style: TextStyles.gradientElevatedButtonText.copyWith(
                              color: ColorName.whiteColor, fontSize: 15.sp),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
