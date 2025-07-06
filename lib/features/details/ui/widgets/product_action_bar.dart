import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/core/common_widgets/gradient_button.dart';
import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:pharmacy/gen/colors.gen.dart';
import 'package:pharmacy/generated/l10n.dart';
import 'package:pharmacy/utils/cart_action.dart';
import '../../../../core/routes/routes.dart';
import '../../../cart/logic/cart/cart_cubit.dart';
import '../../../cart/logic/cart/cart_state.dart' as cart_state;
import '../../../main/logic/main_cubit.dart';

class ProductActionBar extends StatelessWidget {
  final Results product;

  const ProductActionBar({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 11,
      shadowColor: ColorName.blackColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Cart action section
          Expanded(
            flex: 2,
            child: BlocBuilder<CartCubit, cart_state.CartState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: buildCartAction(context, state, product),
                );
              },
            ),
          ),
          
          // Go to cart button
          Expanded(
            flex: 2,
            child: GradientElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.main);
                BlocProvider.of<MainCubit>(context).selectTab(1);
              },
              child: Text(
                S.of(context).goToCart,
                style: TextStyles.gradientElevatedButtonText,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 