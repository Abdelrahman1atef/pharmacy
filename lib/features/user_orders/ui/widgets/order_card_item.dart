import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/common_widgets/gradient_button.dart';
import 'package:pharmacy/features/user_orders/ui/widgets/order_item_widget.dart';

import '../../../../app_config_provider/logic/auth/logic/auth_cubit.dart';
import '../../../../app_config_provider/logic/auth/logic/auth_state.dart';
import '../../../../core/models/order/create/order_request.dart';
import '../../../../core/models/order/customer/customer_order_item_model.dart';
import '../../../../core/models/order/customer/customer_order_model.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/themes/text/text_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/network_image_utils.dart';
import '../../../cart/logic/order/order_cubit.dart';
import 'order_details_dialog.dart';
import 'order_status_widget.dart';

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
              constraints: const BoxConstraints(minHeight: 200),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("#${orderInfo.id}"),
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

                  const SizedBox(height: 16),
                  SimpleOrderStatusIndicator(currentStatus: orderInfo.status,),
                  const SizedBox(height: 16),
                  OrderStatusWidget(
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
                        onPressed: () {
                          final authState = context.read<AuthCubit>().state;

                          if (authState is! AuthAuthenticated) {
                            Navigator.pushNamed(context, Routes.login);
                            return;
                          }

                          final user = authState.user;
                          final orderRequest = OrderRequest(
                              userId: user.id, products: orderItemInfo!);
                          context.read<OrderCubit>().createOrder(orderRequest);
                        },
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

