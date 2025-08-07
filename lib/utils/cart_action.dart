
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/db/cart/model/product.dart';
import '../core/common_widgets/gradient_button.dart';
import '../core/common_widgets/quantity_selector.dart';
import '../core/models/product/product_response.dart';
import '../core/themes/text/text_styles.dart';
import '../features/cart/logic/cart/cart_cubit.dart';
import '../features/cart/logic/cart/cart_state.dart';
import '../features/details/logic/product/product_cubit.dart';
import '../features/details/logic/product/product_state.dart';
import '../gen/colors.gen.dart';
import '../generated/l10n.dart';

// Simple cart checking - no complex caching
class SimpleCartChecker {
  static bool isInCart(CartState state, int? productId) {
    if (productId == null || state is! Success) return false;
    
    // Simple linear search - but only when needed
    for (final item in state.data) {
      if (item.productId == productId) return true;
    }
    return false;
  }
  
  static Product? getCartProduct(CartState state, int? productId) {
    if (productId == null || state is! Success) return null;
    
    for (final item in state.data) {
      if (item.productId == productId) return item;
    }
    return null;
  }
}

Widget buildCartAction(BuildContext context, CartState state, Results product) {
  final isAvailable = product.stockAmount != 0;

  if (!isAvailable) {
    return GradientElevatedButton(
      onPressed: null,
      haveBorder: true,
      gradientColors: const [
        ColorName.whiteColor,
        Colors.grey
      ],
      child: Text(S.of(context).unavailable,style: TextStyles.gradientElevatedButtonText.copyWith(
        color: ColorName.secondaryColor,
            fontWeight: FontWeight.w800,
        fontSize: 13.sp
      ),),
    );
  }

  // Simple cart checking
  final isInCart = SimpleCartChecker.isInCart(state, product.productId);

  if (isInCart) {
    // Get cart product
    final cartProduct = SimpleCartChecker.getCartProduct(state, product.productId);
    if (cartProduct != null) {
      return Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
        child: QuantitySelector(product: cartProduct),
      );
    }
  }

  // Show add to cart button
  return BlocProvider(
    create: (context) => ProductCubit()
      ..selectUnit("productUnit1", product.sellPrice ?? 0.0),
    child: BlocBuilder<ProductCubit, ProductState>(
      builder: (context, productState) {
        return GradientElevatedButton(
          onPressed: () {
            // Get the selected unit type and price from ProductCubit
            String selectedUnitType;
            double selectedUnitPrice;
            
            if (productState.selectedUnit == 'productUnit2' && product.unit2SellPrice != null) {
              selectedUnitType = product.productUnit2 ?? "";
              selectedUnitPrice = product.unit2SellPrice!;
            } else {
              selectedUnitType = product.productUnit1 ?? "";
              selectedUnitPrice = product.sellPrice ?? 0.0;
            }
            
            context.read<CartCubit>().addItemToCart(
              product.toProduct(
                selectedUnitType: selectedUnitType,
                selectedUnitPrice: selectedUnitPrice,
              ),
            );
          },
          child: Text(S.of(context).addToCart,style: TextStyles.gradientElevatedButtonText,),
        );
      },
    ),
  );
}