import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/order/customer/customer_order_model.dart';
import '../../../../core/themes/text/text_styles.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../generated/l10n.dart';
import 'order_method_display_widget.dart';

class OrderMethodsWidget extends StatelessWidget {
  final CustomerOrderModel orderInfo;

  const OrderMethodsWidget({
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

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).orderDetails,
            style: TextStyles.settingsTitle.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: ColorName.blackColor,
            ),
          ),
          SizedBox(height: 16.h),
          
          // Delivery Method
          OrderMethodDisplayWidget.delivery(
            title: S.of(context).orderDetailsAddress,
            deliveryMethod: orderInfo.deliveryMethod,
            context: context,
          ),
          
          SizedBox(height: 16.h),
          
          // Payment Method
          OrderMethodDisplayWidget.payment(
            title: S.of(context).orderDetailsPayment,
            paymentMethod: orderInfo.paymentMethod,
            context: context,
          ),
          
          // Address details if available
          if (orderInfo.addressName != null || orderInfo.addressStreet != null) ...[
            SizedBox(height: 16.h),
            Text(
              S.of(context).orderDetailsAddress,
              style: TextStyles.settingsTitle.copyWith(fontSize: 15.sp),
            ),
            SizedBox(height: 8.h),
            if (orderInfo.addressName != null)
              Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        orderInfo.addressName!,
                        style: TextStyles.orderInfoText.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (orderInfo.addressStreet != null)
              Padding(
                padding: EdgeInsets.only(left: 24.w),
                child: Text(
                  orderInfo.addressStreet!,
                  style: TextStyles.orderInfoText.copyWith(
                    fontSize: 13.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
} 