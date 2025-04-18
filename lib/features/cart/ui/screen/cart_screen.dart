import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:pharmacy/features/cart/logic/cart_cubit.dart';
import 'package:pharmacy/features/cart/logic/cart_state.dart';
import 'package:pharmacy/features/cart/ui/widget/cart_is_empty.dart';
import 'package:pharmacy/features/cart/ui/widget/cart_item.dart';
import 'package:pharmacy/gen/colors.gen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/db/cart/model/product.dart';
import '../../../../generated/l10n.dart';
import '../../../main/presentation/screens/main_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        // Handle loading, error, and empty states
        if (state is Loading) {
          return const _ShimmerWidget();
        } else if (state is Error) {
          return Scaffold(
            body: Center(
              child: Text(
                'Error: ${state.e}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        } else if (state is Success) {
          final cartItems = state.data as List<Product>;
          final cartItemsNum = cartItems.length;
          double totalSellPrice = 0.0;
          for (final product in cartItems) {
            totalSellPrice += product.sellPrice!;
          }

          if (cartItems.isEmpty) {
            return const CartIsEmpty();
          }

          // Build the main scaffold for the cart screen
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return CartItem(
                        product: cartItem,
                      );
                    },
                  ),
                ),
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: const BorderRadiusDirectional.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 10,
                              vertical: 0,
                            ),
                            child: Text(
                              "${S.of(context).subtotal}:",
                              style: TextStyles.cartCheckout,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 10,
                              vertical: 0,
                            ),
                            child: Text(
                              "${S.of(context).pound} $totalSellPrice",
                              style: TextStyles.cartCheckout,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Text(
                          "$cartItemsNum ${cartItemsNum == 1 ? S.of(context).product : S.of(context).ofProducts}",
                          style: TextStyles.cartCheckout,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(bottom: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    mainPageKey.currentState?.changePage(0);
                                  },
                                  style: ButtonStyle(
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(5),
                                      ),
                                    ),
                                  ),
                                  child: Text(S.of(context).continueShopping,style: TextStyles.cartCheckout,),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 10),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor:WidgetStatePropertyAll(ColorName.primaryColor),
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(5),
                                      ),
                                    ),
                                  ),
                                  child: Text(S.of(context).checkout,style: TextStyles.cartCheckout.copyWith(
                                    color: ColorName.whiteColor
                                  ),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const _ShimmerWidget();
        }
      },
    );
  }
}

class _ShimmerWidget extends StatelessWidget {
  const _ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        width: 445.w,
        height: 214.h,
        child: const Card(),
      ),
    );
  }
}
