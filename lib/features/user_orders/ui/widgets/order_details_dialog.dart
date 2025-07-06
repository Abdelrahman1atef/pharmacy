import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/common_widgets/gradient_button.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:pharmacy/features/user_orders/ui/widgets/reorder_helper.dart';
import 'package:pharmacy/features/user_orders/ui/widgets/simple_order_status_indicator.dart';
import 'package:pharmacy/gen/colors.gen.dart';
import '../../../../core/models/order/customer/customer_order_model.dart';
import '../../../../generated/l10n.dart';
import 'order_info_widget.dart';
import 'order_methods_widget.dart';

class OrderDetailsDialog extends StatelessWidget {
  final CustomerOrderModel orderInfo;

  const OrderDetailsDialog({
    super.key,
    required this.orderInfo,
  });

  static Future<Object?> show(
    BuildContext context,
    CustomerOrderModel orderInfo,
  ) async {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'OrderDetails',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return OrderDetailsDialog(orderInfo: orderInfo);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(
          maxWidth: 500,
          maxHeight: 850,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min, // Important: shrink to fit content
            children: [
              // Fixed header section
              _buildHeader(context),
              SizedBox(height: 12.h),

              // Expandable content section
              Expanded(
                child: _buildOrderInfo(context),
              ),

              // Fixed action buttons at bottom
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderInfo(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //status
          orderInfoContainer(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).orderStatus,
                    style: TextStyles.settingsTitle.copyWith(fontSize: 15.sp)),
                SizedBox(
                  height: 8.h,
                ),
                OrderProgressIndicator(
                  currentStatus: orderInfo.status,
                  isVertical: true,
                  height: 200,
                ),
              ],
            ),
          ),
          const Divider(),
          OrderMethodsWidget(orderInfo: orderInfo),
          const Divider(),
          //orderInfo
          orderInfoContainer(OrderInfoWidget(orderInfo: orderInfo)),
          const Divider(),
          orderInfoContainer(_buildCheckout(context)),
          SizedBox(height: 16.h),
          GradientElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ReorderHelper.showReorderOptions(context, orderInfo);
            },
            child: Text(
              S.of(context).reorder,
              style: TextStyles.settingsTitle
                  .copyWith(fontSize: 15.sp, color: ColorName.whiteColor),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("${S.of(context).orderNum}${orderInfo.id}",
            style: TextStyles.settingsTitle),
        Text(orderInfo.getDeliveryMethodText(context),
            style:
                TextStyles.orderInfoText.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Close"),
        ),
      ],
    );
  }

  Widget _buildCheckout(context) {
    TextStyle? style = TextStyles.orderInfoText;
    const double deliveryFees = 15.0;
    double totalPriceWithFees = (orderInfo.totalPrice + deliveryFees);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).subtotal,
              style: style,
            ),
            Text(
              "${orderInfo.totalPrice} ${S.of(context).pound}",
              style: style.copyWith(
                  fontSize: 15.sp,
                  color: ColorName.primaryColor,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        ListTile(
          contentPadding: const EdgeInsetsDirectional.all(0),
          title: Text(
            S.of(context).deliveryFees,
            style: style,
          ),
          subtitle: Text(
            S.of(context).longDistanceFees,
            style: style.copyWith(fontSize: 12.sp),
          ),
          trailing: Text(
            "$deliveryFees ${S.of(context).pound}",
            style: style.copyWith(
                fontSize: 15.sp,
                color: ColorName.primaryColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).total,
              style: style.copyWith(color: ColorName.blackColor),
            ),
            Text(
              "$totalPriceWithFees ${S.of(context).pound}",
              style: style.copyWith(
                  fontSize: 15.sp,
                  color: ColorName.primaryColor,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ],
    );
  }

  Container orderInfoContainer(child) {
    const containerBorderRadius = 15.0;
    Color? containerBGColor = Colors.grey[100];
    const containerPadding = 12.0;
    return Container(
        padding: const EdgeInsetsDirectional.all(containerPadding),
        decoration: BoxDecoration(
            color: containerBGColor,
            borderRadius:
                BorderRadiusDirectional.circular(containerBorderRadius)),
        child: child);
  }
}
