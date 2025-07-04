// Updated checkout_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/common_widgets/gradient_button.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:pharmacy/gen/colors.gen.dart';

import '../../../../app_config_provider/logic/auth/logic/auth_cubit.dart';
import '../../../../app_config_provider/logic/auth/logic/auth_state.dart';
import '../../../../core/db/cart/model/product.dart';
import '../../../../core/models/order/create/order_request.dart';
import '../../../../core/routes/routes.dart';
import '../../../../generated/l10n.dart';
import '../../../cart/logic/order/order_cubit.dart';
import '../../logic/toggle_buttons_logic/checkout_cubit.dart';
import '../../logic/toggle_buttons_logic/checkout_state.dart';
import '../widgets/toggle_buttons.dart';

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
                    LocationSelectionWidget(),
                    SizedBox(height: 20.h),
                    // Add more checkout widgets here
                    _buildOrderSummary(context),
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
      padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 20.h),
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

void _handleCheckout(BuildContext context, List<Product> cartItems, CheckoutState checkoutState) {
  final authState = context.read<AuthCubit>().state;

  if (authState is! AuthAuthenticated) {
    Navigator.pushNamed(context, Routes.login);
    return;
  }

  final user = authState.user;

  // Create order request with delivery method information
  final orderRequest = OrderRequest(
    userId: user.id,
    products: cartItems,
    // You'll need to get these values from your app state or form inputs
    address: "User address here", // Get from user profile or address form
    latitude: 0.0, // Get from location service
    longitude: 0.0, // Get from location service
    paymentMethod: "cash_on_delivery", // Get from payment method selection
    deliveryMethod: checkoutState.deliveryMethod,
    isHomeDelivery: checkoutState.isHomeDeliverySelected,
    callRequestEnabled: checkoutState.isCallRequestEnabled,
    promoCode: checkoutState.promoCode,
  );

  context.read<OrderCubit>().createOrder(orderRequest);
}

class LocationSelectionWidget extends StatelessWidget {
  const LocationSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).delivery,
            style: TextStyles.orderInfoText.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          const DeliveryToggleButtons(),
        ],
      ),
    );
  }
}