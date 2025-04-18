import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/app_bloc_providers.dart';
import 'package:pharmacy/features/cart/logic/cart_cubit.dart';
import 'package:pharmacy/features/cart/logic/cart_state.dart';
import '../../gen/colors.gen.dart';
import '../db/cart/model/product.dart';

class QuantitySelector extends StatefulWidget {
  final Product product;
  const QuantitySelector({super.key, required this.product});

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int _quantity;

  @override
  void initState() {
    _quantity = widget.product.quantity;
    super.initState();
  }
  void _incrementQuantity() {
    setState(() {
      _quantity++;
      // context.read<CartCubit>().updateCartItem(productId, newQuantity)
    });
    context.read<CartCubit>().updateCartItem(widget.product.productId, _quantity);
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
      context.read<CartCubit>().updateCartItem(widget.product.productId, _quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate dynamic sizes based on available width
        final maxWidth = constraints.maxWidth;
        final buttonSize = maxWidth * 0.15; // 15% of available width
        final fontSize = maxWidth * 0.1; // 6% of available width
        final spacing = maxWidth * 0.04; // 4% of available width

        return Card(
          elevation: 5,
          shape: const StadiumBorder(),
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 2, vertical: 2), // Responsive padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Decrement Button
                Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        ColorName.secondaryColor,
                        ColorName.primaryColor
                      ], // Gradient colors
                    ),
                    borderRadius: BorderRadius.circular(35), // Circular shape
                  ),
                  child: IconButton(
                    iconSize: buttonSize, // Responsive icon size
                    icon: const Icon(Icons.remove),
                    onPressed: _decrementQuantity,
                    color: ColorName.whiteColor,
                  ),
                ),
                SizedBox(width: spacing), // Responsive spacing
                // Quantity Text
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    if (state is Loading) {
                      return const CircularProgressIndicator();
                    } else if (state is Error) {
                      return Center(
                        child: Text(
                          'Error: ${state.e}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (state is Success) {
                      // Find the product in the cart state
                      final cartItems = state.data as List<Product>;
                      final product = cartItems.firstWhere(
                            (item) => item.productId == widget.product.productId,
                        orElse: () => widget.product,
                      );
                      return Text(
                        "${product.quantity}",
                        style: TextStyle(
                          fontSize: fontSize, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }else{
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                SizedBox(width: spacing), // Responsive spacing
                // Increment Button
                Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        ColorName.secondaryColor,
                        ColorName.primaryColor
                      ], // Gradient colors
                    ),
                    borderRadius: BorderRadius.circular(35), // Circular shape
                  ),
                  child: IconButton(
                    iconSize: buttonSize, // Responsive icon size
                    icon: const Icon(Icons.add),
                    onPressed: _incrementQuantity,
                    color: ColorName.whiteColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
