
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/common_widgets/gradient_button.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:pharmacy/features/cart/logic/order/order_state.dart';
import 'package:pharmacy/features/checkout/logic/payment/payment_cubit.dart';
import 'package:pharmacy/features/checkout/ui/widgets/discount_section_widget.dart';
import 'package:pharmacy/gen/colors.gen.dart';

import '../../../../app_config_provider/logic/auth/logic/auth_cubit.dart';
import '../../../../app_config_provider/logic/auth/logic/auth_state.dart';
import '../../../../core/db/cart/model/product.dart';
import '../../../../core/models/order/create/order_request.dart';
import '../../../../core/routes/routes.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/constant.dart';
import '../../../cart/logic/cart/cart_cubit.dart';
import '../../../cart/logic/order/order_cubit.dart';
import '../../logic/toggle_buttons_logic/checkout_cubit.dart';
import '../../logic/toggle_buttons_logic/checkout_state.dart';
import '../widgets/deliver_section_widget.dart';
import '../widgets/location_section_widget.dart';
import '../widgets/order_summary_section_widget.dart';
import '../widgets/payment_section_widget.dart';
import '../../logic/location/location_cubit.dart';
import '../../logic/payment/payment_helper.dart';
import '../../logic/branch/branch_cubit.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Product> cartItems;

  const CheckoutScreen({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderCubit, OrderState>(
      listener: (context, state) {
        final scaffold = ScaffoldMessenger.of(context);
        state.maybeWhen(
          loading: () {
            scaffold.hideCurrentSnackBar();
            scaffold.showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(width: 16),
                    Text(S.of(context).processingOrder),
                  ],
                ),
                duration: const Duration(minutes: 1),
                dismissDirection: DismissDirection.none,
              ),
            );
          },
          error: (e) {
            scaffold.hideCurrentSnackBar();
            scaffold.showSnackBar(
              SnackBar(
                content: Text(e.message),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          },
          success: (data) {
            scaffold.hideCurrentSnackBar();
            context.read<CartCubit>().dropCartItem();
            scaffold.showSnackBar(
              SnackBar(
                content: Text("Order successful! ID: ${data.message}"),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 4),
              ),
            );
            Navigator.pop(context);
          },
          orElse: () {},
        );
      },
      child: BlocProvider(
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
      ),
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
  final paymentState = context.read<PaymentCubit>().state;
  final selectedLocation = context.read<LocationCubit>().state;

  // Validate delivery method selection
  if (checkoutState.isHomeDeliverySelected) {
    // Validate address selection for home delivery
    if (selectedLocation == null) {
      _showAddressErrorDialog(context);
      return;
    }
  } else {
    // Validate pharmacy selection for pharmacy pickup
    final branchState = context.read<BranchCubit>().state;
    branchState.when(
      initial: () {
        _showPharmacyErrorDialog(context);
        return;
      },
      loading: () {
        _showPharmacyErrorDialog(context);
        return;
      },
      loaded: (branches) {
        _showPharmacyErrorDialog(context);
        return;
      },
      selected: (branches, selectedBranch) {
        // Pharmacy is selected, continue with checkout
      },
      error: (message) {
        _showPharmacyErrorDialog(context);
        return;
      },
    );
  }

  // Convert payment index to PaymentMethod enum using helper
  final paymentMethod = PaymentHelper.getPaymentMethodFromIndex(paymentState.selectedPaymentIndex);

  // Prepare order request based on delivery method
  OrderRequest orderRequest;
  
  if (checkoutState.isHomeDeliverySelected) {
    // Home delivery order
    orderRequest = OrderRequest(
      userId: user.id,
      products: cartItems,
      address: selectedLocation!.name,
      addressName: selectedLocation.name,
      addressStreet: selectedLocation.street,
      latitude: selectedLocation.latitude,
      longitude: selectedLocation.longitude,
      paymentMethod: paymentMethod,
      deliveryMethod: checkoutState.deliveryMethod,
      deliveryFee: Constant.deliveryFee,
      isHomeDelivery: true,
      callRequestEnabled: checkoutState.isCallRequestEnabled,
      promoCode: checkoutState.promoCode,
    );
  } else {
    // Pharmacy pickup order
    final branchState = context.read<BranchCubit>().state;
    orderRequest = branchState.when(
      initial: () => throw Exception('No pharmacy selected'),
      loading: () => throw Exception('No pharmacy selected'),
      loaded: (branches) => throw Exception('No pharmacy selected'),
      selected: (branches, selectedBranch) => OrderRequest(
        userId: user.id,
        products: cartItems,
        paymentMethod: paymentMethod,
        deliveryMethod: checkoutState.deliveryMethod,
        deliveryFee: 0.0, // No delivery fee for pharmacy pickup
        isHomeDelivery: false,
        callRequestEnabled: checkoutState.isCallRequestEnabled,
        promoCode: checkoutState.promoCode,
        branchId: selectedBranch.branchId,
        pharmacyName: selectedBranch.branchName,
      ),
      error: (message) => throw Exception('No pharmacy selected'),
    );
  }
   context.read<OrderCubit>().createOrder(orderRequest);
}

void _showAddressErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          S.of(context).error,
          style: TextStyles.orderInfoText.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        content: Text(
          S.of(context).selectAddressError,
          style: TextStyles.orderInfoText.copyWith(
            fontSize: 14,
            color: ColorName.productDetailTextColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: TextStyles.orderInfoText.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      );
    },
  );
}

void _showPharmacyErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          S.of(context).error,
          style: TextStyles.orderInfoText.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        content: Text(
          S.of(context).selectPharmacyError,
          style: TextStyles.orderInfoText.copyWith(
            fontSize: 14,
            color: ColorName.productDetailTextColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: TextStyles.orderInfoText.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      );
    },
  );
}




















