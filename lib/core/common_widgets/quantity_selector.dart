import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/features/cart/logic/cart/cart_cubit.dart';
import 'package:pharmacy/features/cart/ui/widget/cart_item_widget.dart';
import '../../features/cart/logic/cart/cart_state.dart';
import '../../gen/colors.gen.dart';
import '../db/cart/model/product.dart';

class QuantitySelector extends StatelessWidget {
  final Product product;

  const QuantitySelector({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return _QuantitySelectorBody(product: product);
  }
}

class _QuantitySelectorBody extends StatelessWidget {
  final Product product;

  const _QuantitySelectorBody({required this.product});

  void _handleDecrement(BuildContext context, int quantity) {
    final cartCubit = context.read<CartCubit>();

    if (quantity > 1) {
      cartCubit.updateCartItem(product.productId, quantity - 1);
    } else {
      CartItemWidget.showConfirmationDialog(context, product);
    }
  }

  void _handleIncrement(BuildContext context, int quantity) {
    final cartCubit = context.read<CartCubit>();
    cartCubit.updateCartItem(product.productId, quantity + 1);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final buttonSize = maxWidth * 0.15;
        final fontSize = maxWidth * 0.1;
        final spacing = maxWidth * 0.04;

        return Card(
          elevation: 5,
          shape: const StadiumBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                int quantity = product.quantity;

                if (state is Success) {
                  final updatedProduct = state.data.firstWhere(
                        (p) => p.productId == product.productId,
                    orElse: () => product,
                  );
                  quantity = updatedProduct.quantity;
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _incDecButton(
                      context,
                      fun: () => _handleDecrement(context, quantity),
                      icon: Icons.remove,
                      buttonSize: buttonSize,
                    ),
                    SizedBox(width: spacing),
                    Text(
                      "$quantity",
                      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: spacing),
                    _incDecButton(
                      context,
                      fun: () => _handleIncrement(context, quantity),
                      icon: Icons.add,
                      buttonSize: buttonSize,
                    ),
                  ],
                );
              },
            )

          ),
        );
      },
    );
  }

  Widget _incDecButton(
      BuildContext context, {
        required VoidCallback fun,
        required IconData icon,
        required double buttonSize,
      }) {
    return Ink(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            ColorName.secondaryColor,
            ColorName.primaryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(35),
      ),
      child: IconButton(
        iconSize: buttonSize,
        icon: Icon(icon),
        onPressed: fun,
        color: ColorName.whiteColor,
      ),
    );
  }
}
