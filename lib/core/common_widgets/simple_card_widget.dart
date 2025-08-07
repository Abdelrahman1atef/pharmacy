import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/cart/logic/cart/cart_cubit.dart';
import '../../features/cart/logic/cart/cart_state.dart';
import '../../features/details/logic/product/product_cubit.dart';
import '../../features/details/logic/product/product_state.dart';
import '../../gen/assets.gen.dart';
import '../../gen/colors.gen.dart';
import '../../generated/l10n.dart';
import '../../utils/network_image_utils.dart';
import '../models/product/product_response.dart';
import '../routes/routes.dart';
import '../themes/text/text_styles.dart';
import '../db/cart/model/product.dart';

// Efficient cart status cache
class CartStatusCache {
  static final Map<int, bool> _cache = {};
  static int _lastCartHash = 0;
  
  static bool isProductInCart(CartState state, int? productId) {
    if (productId == null || state is! Success) return false;
    
    // Calculate hash of cart data to detect changes
    final cartHash = state.data.fold(0, (hash, item) => hash + item.productId);
    
    // Only recalculate if cart actually changed
    if (cartHash != _lastCartHash) {
      _cache.clear();
      _lastCartHash = cartHash;
      
      // Build cache once for all products
      for (final item in state.data) {
        _cache[item.productId] = true;
      }
    }
    
    // O(1) lookup from cache
    return _cache[productId] ?? false;
  }
  
  static void clearCache() {
    _cache.clear();
    _lastCartHash = 0;
  }
}

class SimpleCardWidget extends StatefulWidget {
  final Results product;
  final bool itemListSize;

  const SimpleCardWidget({
    super.key,
    required this.product,
    this.itemListSize = false,
  });

  @override
  State<SimpleCardWidget> createState() => _SimpleCardWidgetState();
}

class _SimpleCardWidgetState extends State<SimpleCardWidget> {
  @override
  void initState() {
    super.initState();
    // Only emit cart state once when widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CartCubit>().emitCartState();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()
        ..selectUnit("productUnit1", widget.product.sellPrice ?? 0.0),
      child: InkWell(
        onTap:() =>  Navigator.pushNamed(
            context, Routes.productDetail,
            arguments: widget.product.productId),
          borderRadius: BorderRadius.circular(12),
        child: BlocBuilder<CartCubit, CartState>(
          // Only rebuild if this specific product's cart status changed
          buildWhen: (previous, current) {
            final prevInCart = CartStatusCache.isProductInCart(previous, widget.product.productId);
            final currInCart = CartStatusCache.isProductInCart(current, widget.product.productId);
            return prevInCart != currInCart;
          },
          builder: (context, cartState) => SizedBox(
            width: 180.w,
            height: 300.h,
            child: Card(
              color: ColorName.whiteColor,
              shadowColor: ColorName.blackColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildProductDetails(context),
                    _buildCartButton(context, cartState),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            SizedBox(
              height: 120.h,
              width: double.infinity,
              child: Image.network(
                (widget.product.productImages != null && widget.product.productImages!.isNotEmpty)
                    ? widget.product.productImages!.first
                    : "", // Or use a default image URL here
                fit: BoxFit.cover,
                loadingBuilder: loadingBuilder(),
                errorBuilder: errorBuilder(Assets.images.pWatermarkV2.path),
              ),
            ),
            ///TODO: Add favorite icon
            // Container(
            //   width: 32.w,
            //   height: 32.w,
            //   decoration: const BoxDecoration(
            //     color: Colors.white,
            //     shape: BoxShape.circle,
            //   ),
            //   child: BlocBuilder<FavoriteCubit, FavoriteState>(
            //     builder: (context, state) {
            //       return IconButton(
            //         icon: Assets.images.heart.svg(
            //           width: 16.w,
            //           height: 16.w,
            //           colorFilter: ColorFilter.mode(
            //             state.when(
            //               initial: () => Colors.grey,
            //               favorited: () => Colors.red,
            //               notFavorited: () => Colors.grey,
            //             ),
            //             BlendMode.srcIn,
            //           ),
            //         ),
            //         onPressed: () {
            //           context.read<FavoriteCubit>().toggleFavorite();
            //         },
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          widget.product.productNameAr!,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyles.productHomeTitles,
        ),
        SizedBox(height: 8.h),
        Text(
          "${S.of(context).pound} ${widget.product.sellPrice?.toInt()}",
          style: TextStyles.productPriceHomeTitles,
        ),
      ],
    );
  }

  Widget _buildCartButton(BuildContext context, CartState cartState) {
    final isAvailable = widget.product.stockAmount != 0;

    if (!isAvailable) {
      return Container(
        width: double.infinity,
        height: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [ColorName.whiteColor, Colors.grey],
          ),
        ),
        child: Center(
          child: Text(
            S.of(context).unavailable,
            style: TextStyles.gradientElevatedButtonText.copyWith(
              color: ColorName.secondaryColor,
              fontWeight: FontWeight.w800,
              fontSize: 13.sp
            ),
          ),
        ),
      );
    }

    // Efficient cart checking using cache
    final isInCart = CartStatusCache.isProductInCart(cartState, widget.product.productId);

    if (isInCart) {
      // Show increment/decrement layout when product is in cart
      return _buildIncrementDecrementLayout(context, cartState);
    }

    // Show "Add to Cart" button
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, productState) {
        return Container(
          width: double.infinity,
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
              colors: [ColorName.primaryColor, ColorName.secondaryColor],
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                // Get the selected unit type and price from ProductCubit
                String selectedUnitType;
                double selectedUnitPrice;
                
                if (productState.selectedUnit == 'productUnit2' && widget.product.unit2SellPrice != null) {
                  selectedUnitType = widget.product.productUnit2 ?? "";
                  selectedUnitPrice = widget.product.unit2SellPrice!;
                } else {
                  selectedUnitType = widget.product.productUnit1 ?? "";
                  selectedUnitPrice = widget.product.sellPrice ?? 0.0;
                }
                
                context.read<CartCubit>().addItemToCart(
                  widget.product.toProduct(
                    selectedUnitType: selectedUnitType,
                    selectedUnitPrice: selectedUnitPrice,
                  ),
                );
              },
              child: Center(
                child: Text(
                  S.of(context).addToCart,
                  style: TextStyles.gradientElevatedButtonText,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIncrementDecrementLayout(BuildContext context, CartState cartState) {
    // Find the cart item for this product
    final cartItem = cartState is Success 
        ? cartState.data.firstWhere(
            (item) => item.productId == widget.product.productId,
            orElse: () => Product(
              productId: widget.product.productId ?? 0,
              productNameAr: widget.product.productNameAr ?? '',
              productImages: widget.product.productImages ?? [],
              selectedUnitType: widget.product.productUnit1 ?? '',
              selectedUnitPrice: widget.product.sellPrice ?? 0.0,
              quantity: 1,
            ),
          )
        : Product(
            productId: widget.product.productId ?? 0,
            productNameAr: widget.product.productNameAr ?? '',
            productImages: widget.product.productImages ?? [],
            selectedUnitType: widget.product.productUnit1 ?? '',
            selectedUnitPrice: widget.product.sellPrice ?? 0.0,
            quantity: 1,
          );

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _incDecButton(
                  context,
                  fun: () => _handleDecrement(context, cartItem),
                  icon: Icons.remove,
                  buttonSize: buttonSize,
                ),
                SizedBox(width: spacing),
                Text(
                  "${cartItem.quantity}",
                  style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: spacing),
                _incDecButton(
                  context,
                  fun: () => _handleIncrement(context, cartItem),
                  icon: Icons.add,
                  buttonSize: buttonSize,
                ),
              ],
            ),
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

  void _handleDecrement(BuildContext context, Product cartItem) {
    final cartCubit = context.read<CartCubit>();

    if (cartItem.quantity > 1) {
      cartCubit.updateCartItem(cartItem.productId, cartItem.quantity - 1);
    } else {
      // Remove item if quantity becomes 0
      cartCubit.deleteCartItem(cartItem.productId);
    }
  }

  void _handleIncrement(BuildContext context, Product cartItem) {
    final cartCubit = context.read<CartCubit>();
    cartCubit.updateCartItem(cartItem.productId, cartItem.quantity + 1);
  }
} 