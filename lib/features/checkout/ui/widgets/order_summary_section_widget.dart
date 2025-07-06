import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/features/checkout/logic/toggle_buttons_logic/checkout_cubit.dart';
import 'package:pharmacy/features/checkout/logic/toggle_buttons_logic/checkout_state.dart';
import '../../../../core/db/cart/model/product.dart';
import '../../../../core/themes/text/text_styles.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../generated/l10n.dart';

class OrderSummarySectionWidget extends StatelessWidget {
  final List<Product> cartItems;

  const OrderSummarySectionWidget({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        double? subtotal = 0;
        const double deliveryFee = 15;
        double total = 0;
        subtotal = cartItems.fold(
            0, (sum, item) => sum + (item.selectedUnitPrice! * item.quantity));
        if (state.isHomeDeliverySelected) {
          total = (subtotal + deliveryFee);
        } else {
          total = subtotal;
        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S
                        .of(context)
                        .orderSummary,
                    style: TextStyles.orderInfoText.copyWith(
                        fontSize: 18.sp,
                        color: ColorName.blackColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S
                      .of(context)
                      .subtotal,
                      style: TextStyles.orderInfoText
                          .copyWith(
                          fontSize: 18.sp, color: ColorName.blackColor)),
                  Text(
                    "${S.of(context).pound} ${(subtotal).toStringAsFixed(2)}",
                    style: TextStyles.orderInfoText.copyWith(
                        fontSize: 14.sp,
                        color: ColorName.primaryColor,
                        fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              Visibility(
                visible: state.isHomeDeliverySelected,
                child: ListTile(
                  contentPadding: const EdgeInsetsDirectional.all(0),
                  title: Text(S
                      .of(context)
                      .deliveryFees,
                      style: TextStyles.orderInfoText
                          .copyWith(
                          fontSize: 18.sp, color: ColorName.blackColor)),
                  trailing: Text(
                    "${S.of(context).pound} $deliveryFee",
                    style: TextStyles.orderInfoText
                        .copyWith(fontSize: 18.sp,
                        color: ColorName.primaryColor,
                        fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    S
                        .of(context)
                        .longDistanceFees,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S
                      .of(context)
                      .total,
                      style: TextStyles.orderInfoText
                          .copyWith(fontSize: 18.sp,
                          color: ColorName.blackColor,
                          fontWeight: FontWeight.bold)),
                  Text(
                    "${S.of(context).pound} ${(total).toStringAsFixed(2)}",
                    style: TextStyles.orderInfoText
                        .copyWith(fontSize: 18.sp,
                        color: ColorName.primaryColor,
                        fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
