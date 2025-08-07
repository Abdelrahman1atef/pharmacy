import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/details/logic/favorite/favorite_cubit.dart';
import '../../features/details/logic/favorite/favorite_state.dart';
import '../../features/details/logic/product/product_cubit.dart';
import '../../gen/assets.gen.dart';
import '../../gen/colors.gen.dart';
import '../../generated/l10n.dart';
import '../../utils/network_image_utils.dart';
import '../models/product/product_response.dart';
import '../routes/routes.dart';
import '../themes/text/text_styles.dart';

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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()
        ..selectUnit("productUnit1", widget.product.sellPrice ?? 0.0),
      child: InkWell(
        onTap:() =>  Navigator.pushNamed(
            context, Routes.productDetail,
            arguments: widget.product.productId),
          borderRadius: BorderRadius.circular(12),
        child: SizedBox(
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
                  _buildSimpleAddButton(context),
                ],
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
            Container(
              width: 32.w,
              height: 32.w,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: BlocBuilder<FavoriteCubit, FavoriteState>(
                builder: (context, state) {
                  return IconButton(
                    icon: Assets.images.heart.svg(
                      width: 16.w,
                      height: 16.w,
                      colorFilter: ColorFilter.mode(
                        state.when(
                          initial: () => Colors.grey,
                          favorited: () => Colors.red,
                          notFavorited: () => Colors.grey,
                        ),
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: () {
                      context.read<FavoriteCubit>().toggleFavorite();
                    },
                  );
                },
              ),
            ),
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

  Widget _buildSimpleAddButton(BuildContext context) {
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
                // Simple add to cart - no complex logic
                print('DEBUG: Would add product ${widget.product.productId} to cart');
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
} 