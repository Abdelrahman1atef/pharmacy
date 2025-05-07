import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/db/cart/model/product.dart';
import '../core/common_widgets/gradient_button.dart';
import '../core/common_widgets/quantity_selector.dart';
import '../core/models/product/product_response.dart';
import '../core/themes/text/text_styles.dart';
import '../features/cart/logic/cart_cubit.dart';
import '../features/cart/logic/cart_state.dart';
import '../gen/colors.gen.dart';
import '../generated/l10n.dart';


Widget buildCartAction(BuildContext context, CartState state, Results product) {
  final isAvailable = product.amount != 0;

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

  if (state is Success) {
    final isInCart = state.data.any((p) => p.productId == product.toProduct().productId);

    if (isInCart) {
      // Get latest product from cart
      final Product cartProduct = state.data.firstWhere(
            (p) => p.productId == product.productId,
        orElse: () => product.toProduct(), // fallback
      );

      return BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
            child: QuantitySelector(product: cartProduct),
          );
        },
      );
    } else {
      return GradientElevatedButton(
        onPressed: () {
          context.read<CartCubit>().addItemToCart(product.toProduct());
        },
        child: Text(S.of(context).addToCart,style: TextStyles.gradientElevatedButtonText,),
      );
    }
  } else {
    return const Center(child: CircularProgressIndicator());
  }
}