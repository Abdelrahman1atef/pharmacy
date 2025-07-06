import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/routes/routes.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:pharmacy/features/cart/ui/widget/cart_is_empty_widget.dart';
import 'package:pharmacy/features/cart/ui/widget/cart_item_widget.dart';
import 'package:pharmacy/gen/colors.gen.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../app_config_provider/logic/auth/logic/auth_cubit.dart';
import '../../../../app_config_provider/logic/auth/logic/auth_state.dart';
import '../../../../core/db/cart/model/product.dart';
import '../../../../generated/l10n.dart';
import '../../../main/logic/main_cubit.dart';
import '../../logic/cart/cart_cubit.dart';
import '../../logic/cart/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is Loading) {
          return _ShimmerWidget();
        } else if (state is Error) {
          return Center(child: Text('Error: ${state.e}'));
        } else if (state is Success) {
          final cartItems = state.data as List<Product>;
          final cartItemsNum = cartItems.length;

          if (cartItems.isEmpty) {
            return const CartIsEmpty();
          }

          double totalSellPrice = cartItems.fold(
              0, (sum, item) => sum + (item.selectedUnitPrice! * item.quantity));

          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: _buildProductList(context, cartItems),
                ),
                _buildCheckoutSection(
                    context, cartItemsNum, totalSellPrice, cartItems),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
  Widget _buildProductList(BuildContext context, List<Product> cartItems) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 500) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: cartItems.length,
        itemBuilder: (context, index) => CartItemWidget(product: cartItems[index]),
      );
    } else {
      return ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) => CartItemWidget(product: cartItems[index]),
      );
    }
  }

  Widget _buildCheckoutSection(
      BuildContext context, int cartItemsNum, double totalSellPrice, List<Product> cartItems) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${S.of(context).subtotal}:", style: TextStyles.cartCheckout),
              Text("${S.of(context).pound} $totalSellPrice", style: TextStyles.cartCheckout),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "$cartItemsNum ${cartItemsNum == 1 ? S.of(context).product : S.of(context).ofProducts}",
            style: TextStyles.cartCheckout,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildActionButton(
                text: S.of(context).continueShopping,
                onPressed: () => context.read<MainCubit>().selectTab(0),
              ),
              const SizedBox(width: 8),
              _buildActionButton(
                text: S.of(context).proceedToCheckout,
                backgroundColor: ColorName.primaryColor,
                textColor: ColorName.whiteColor,
                onPressed: () {
                  final authState = context.read<AuthCubit>().state;

                  if (authState is! AuthAuthenticated) {
                    Navigator.pushNamed(context, Routes.login);
                    return;
                  }else{
                    Navigator.pushNamed(
                        context, Routes.checkOutScreen, arguments: cartItems);
                  }

                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Text(
          text,
          style: TextStyles.cartCheckout.copyWith(color: textColor),
        ),
      ),
    );
  }


}

class _ShimmerWidget extends StatelessWidget {
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