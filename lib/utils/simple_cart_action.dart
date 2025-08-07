import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/db/cart/model/product.dart';
import '../core/common_widgets/gradient_button.dart';
import '../core/models/product/product_response.dart';
import '../core/themes/text/text_styles.dart';
import '../features/cart/logic/cart/cart_cubit.dart';
import '../features/cart/logic/cart/cart_state.dart';
import '../features/details/logic/product/product_cubit.dart';
import '../features/details/logic/product/product_state.dart';
import '../gen/colors.gen.dart';
import '../generated/l10n.dart';

// Ultra-simple cart action - no complex logic
Widget buildSimpleCartAction(BuildContext context, CartState state, Results product) {
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

  // Ultra-simple cart checking - just show add button for now
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