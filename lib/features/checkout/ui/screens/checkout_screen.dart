import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/common_widgets/gradient_button.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:pharmacy/features/checkout/logic/payment/payment_cubit.dart';
import 'package:pharmacy/features/checkout/ui/widgets/discount_section_widget.dart';
import 'package:pharmacy/gen/colors.gen.dart';

import '../../../../app_config_provider/logic/auth/logic/auth_cubit.dart';
import '../../../../app_config_provider/logic/auth/logic/auth_state.dart';
import '../../../../core/db/cart/model/product.dart';
import '../../../../core/models/order/create/order_request.dart';
import '../../../../core/routes/routes.dart';
import '../../../../generated/l10n.dart';
import '../../../admin/orders/logic/admin_orders_state.dart';
import '../../../cart/logic/order/order_cubit.dart';
import '../../logic/toggle_buttons_logic/checkout_cubit.dart';
import '../../logic/toggle_buttons_logic/checkout_state.dart';
import '../widgets/deliver_section_widget.dart';
import '../widgets/location_section_widget.dart';
import '../widgets/order_summary_section_widget.dart';
import '../widgets/payment_section_widget.dart';
import '../../logic/location/location_cubit.dart';
import '../../logic/location/saved_location.dart';
import '../../logic/payment/payment_options.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Product> cartItems;

  const CheckoutScreen({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutCubit(),
      child: Scaffold(
        appBar: const PharmacyAppBar(
          isGeneralLayout: false,
          heightFactor: 1.1,
        ),
        body: Column(
          children: [
            SizedBox(height: 10.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      S.of(context).checkout,
                      style: TextStyles.orderInfoText.copyWith(
                        fontSize: 30,
                        color: ColorName.productDetailTextColor,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    const LocationSelectionWidget(),
                    SizedBox(height: 20.h),
                    const DeliverSectionWidget(),
                    SizedBox(height: 20.h),
                     const PaymentSectionWidget(),
                    SizedBox(height: 20.h),
                    const DiscountSectionWidget(),
                    SizedBox(height: 20.h),
                    OrderSummarySectionWidget(cartItems: cartItems,),
                    // _buildOrderSummary(context),
                  ],
                ),
              ),
            ),
            _buildCheckoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).orderSummary,
                style: TextStyles.orderInfoText.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).delivery,
                    style: TextStyles.productTitles,
                  ),
                  Text(
                    state.isHomeDeliverySelected
                        ? S.of(context).homeDelivery
                        : S.of(context).pharmacyPickup,
                    style: TextStyles.productTitles.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // Add more order summary details here
            ],
          ),
        );
      },
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return Container(
      color: Colors.blue[100],
      padding:
          EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 20.h),
      child: BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, checkoutState) {
          return GradientElevatedButton(
            onPressed: () => _handleCheckout(context, cartItems, checkoutState),
            child: Text(
              S.of(context).checkout,
              style: TextStyles.orderInfoText.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: ColorName.whiteColor,
              ),
            ),
          );
        },
      ),
    );
  }
}

void _handleCheckout(BuildContext context, List<Product> cartItems,
    CheckoutState checkoutState) {
  final authState = context.read<AuthCubit>().state;

  if (authState is! AuthAuthenticated) {
    Navigator.pushNamed(context, Routes.login);
    return;
  }

  final user = authState.user;
  final paymentMethod = context.read<PaymentCubit>().state;
  final selectedLocation = context.read<LocationCubit>().state;

  final orderRequest = OrderRequest(
    userId: user.id,
    products: cartItems,
    address: selectedLocation?.street ?? "No address selected",
    latitude: selectedLocation?.latitude ?? 0.0,
    longitude: selectedLocation?.longitude ?? 0.0,
    paymentMethod: paymentMethod.selectedPaymentIndex == 0
        ? "cash_on_delivery"
        : paymentMethod.selectedPaymentIndex == 1
        ? "debit_credit_card"
        : paymentMethod.selectedPaymentIndex == 2
        ?"debit_credit_card_on_delivery"
        : null,
    deliveryMethod: checkoutState.deliveryMethod,
    isHomeDelivery: checkoutState.isHomeDeliverySelected,
    callRequestEnabled: checkoutState.isCallRequestEnabled,
    promoCode: checkoutState.promoCode,
  );

  context.read<OrderCubit>().createOrder(orderRequest);
  if(context.read<OrderCubit>().state is Success) {
    Navigator.pop(context);
  }
}
