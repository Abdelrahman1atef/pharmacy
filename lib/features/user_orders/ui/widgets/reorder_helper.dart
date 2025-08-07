import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/app_config_provider/logic/auth/logic/auth_cubit.dart';
import 'package:pharmacy/app_config_provider/logic/auth/logic/auth_state.dart';
import 'package:pharmacy/core/db/cart/model/product.dart';
import 'package:pharmacy/core/enum/delivery_method.dart';
import 'package:pharmacy/core/models/order/create/order_request.dart';
import 'package:pharmacy/core/models/order/customer/customer_order_model.dart';
import 'package:pharmacy/core/routes/routes.dart';
import 'package:pharmacy/features/cart/logic/order/order_cubit.dart';
import 'package:pharmacy/features/checkout/ui/screens/checkout_screen.dart';
import 'package:pharmacy/generated/l10n.dart';
import '../../../../core/common_widgets/custom_snackbar.dart';
import '../../../../utils/constant.dart';


class ReorderHelper {
  /// Direct reorder using the original order data
  static void directReorder(BuildContext context, CustomerOrderModel orderInfo) {
    final authState = context.read<AuthCubit>().state;

    if (authState is! AuthAuthenticated) {
      Navigator.pushNamed(context, Routes.login);
      return;
    }

    final user = authState.user;
    
    if (orderInfo.items == null || orderInfo.items!.isEmpty) {
      CustomSnackBar.showError(
        context,
        S.of(context).noItemsToReorder,
      );
      return;
    }

    if(orderInfo.items!=null){

      final orderItemInfo = orderInfo.items ;

      final orderRequest = OrderRequest(
        userId: user.id,
        products: orderItemInfo!,
        address: orderInfo.addressName ?? "No address selected",
        addressName: orderInfo.addressName ?? "No address selected",
        addressStreet: orderInfo.addressStreet ?? "No street selected",
        latitude: orderInfo.latitude ?? 0.0,
        longitude: orderInfo.longitude ?? 0.0,
        paymentMethod: orderInfo.paymentMethod,
        deliveryMethod: orderInfo.deliveryMethod ?? DeliveryMethod.homeDelivery,
        deliveryFee: orderInfo.isHomeDelivery ? Constant.deliveryFee:0.0,
        isHomeDelivery: orderInfo.isHomeDelivery,
        callRequestEnabled: orderInfo.callRequestEnabled ?? false,
        promoCode: orderInfo.promoCode,
      );
      context.read<OrderCubit>().createOrder(orderRequest);
    }

    CustomSnackBar.showSuccess(
      context,
      S.of(context).reorderProcessing,
    );
  }

  /// Reorder with checkout - allows user to modify details
  static void reorderWithCheckout(BuildContext context, CustomerOrderModel orderInfo) {
    final authState = context.read<AuthCubit>().state;

    if (authState is! AuthAuthenticated) {
      Navigator.pushNamed(context, Routes.login);
      return;
    }

    if (orderInfo.items == null || orderInfo.items!.isEmpty) {
      CustomSnackBar.showError(
        context,
        S.of(context).noItemsToReorder,
      );
      return;
    }

    // Convert CustomerOrderItemModel to Product for cart
    final products = orderInfo.items!.map((item) => Product(
      productId: item.productId,
      productNameEn: item.nameEn,
      productNameAr: item.nameAr,
      selectedUnitType: item.unitType,
      selectedUnitPrice: double.tryParse(item.sellPrice ?? item.unitPrice),
      quantity: item.quantity,
      productImages: item.productImages,
    )).toList();

    // Navigate to checkout with pre-filled cart
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(cartItems: products),
      ),
    );
  }

  /// Show reorder options dialog
  static void showReorderOptions(BuildContext context, CustomerOrderModel orderInfo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).reorder),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(S.of(context).reorderOptions),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: Text(S.of(context).directReorder),
                subtitle: Text(S.of(context).directReorderDescription),
                onTap: () {
                  Navigator.pop(context);
                  directReorder(context, orderInfo);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: Text(S.of(context).reorderWithCheckout),
                subtitle: Text(S.of(context).reorderWithCheckoutDescription),
                onTap: () {
                  Navigator.pop(context);
                  reorderWithCheckout(context, orderInfo);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(S.of(context).cancel),
            ),
          ],
        );
      },
    );
  }
} 