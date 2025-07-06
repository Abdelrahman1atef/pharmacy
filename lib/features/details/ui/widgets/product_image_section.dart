import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:pharmacy/gen/colors.gen.dart';
import 'package:pharmacy/gen/assets.gen.dart';
import 'package:pharmacy/generated/l10n.dart';
import 'package:pharmacy/utils/network_image_utils.dart';
import '../../logic/favorite/favorite_cubit.dart';
import '../../logic/favorite/favorite_state.dart';

class ProductImageSection extends StatelessWidget {
  final Results product;

  const ProductImageSection({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 385.h,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          // Background container
          Container(
            width: double.infinity,
            height: double.infinity,
            color: ColorName.secondaryColor.withOpacity(0.1),
          ),
          
          // Product image
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 10,
              start: 50,
              end: 50,
            ),
            child: Image.network(
              (product.productImages != null && product.productImages!.isNotEmpty)
                  ? product.productImages!.first
                  : "",
              fit: BoxFit.cover,
              loadingBuilder: loadingBuilder(),
              errorBuilder: errorBuilder(Assets.images.pWatermarkV2.path),
            ),
          ),
          
          // Heart Icon (Top-Right)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: BlocBuilder<FavoriteCubit, FavoriteState>(
                builder: (context, state) {
                  return IconButton(
                    icon: Assets.images.heart.svg(
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
          ),
          
          // Best Seller Badge (Top-Left)
          Visibility(
            visible: true, // TODO: Make this dynamic based on product data
            child: Positioned(
              top: 8,
              left: 8,
              child: Container(
                margin: const EdgeInsetsDirectional.only(top: 5, start: 5),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: ColorName.bestSellerBgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  S.of(context).best_seller,
                  style: TextStyles.bestSellerText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 