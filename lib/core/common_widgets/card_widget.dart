import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/cart/logic/cart_cubit.dart';
import '../../features/cart/logic/cart_state.dart';
import '../../features/details/logic/favorite/favorite_cubit.dart';
import '../../features/details/logic/favorite/favorite_state.dart';
import '../../gen/assets.gen.dart';
import '../../gen/colors.gen.dart';
import '../../generated/l10n.dart';
import '../../utils/cart_action.dart';
import '../../utils/network_image_utils.dart';
import '../models/product/product_response.dart';
import '../routes/routes.dart';
import '../themes/text/text_styles.dart';

class CardWidget extends StatefulWidget {
  final Results product;
  final bool itemListSize;

  const CardWidget({
    super.key,
    required this.product,
    this.itemListSize = false,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  void initState() {
    context.read<CartCubit>().emitCartState();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() =>  Navigator.pushNamed(
          context, Routes.productDetail,
          arguments: widget.product.productId),
        borderRadius: BorderRadius.circular(12),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return SizedBox(
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
                    buildCartAction(context, state,widget.product),
                  ],
                ),
              ),
            ),
          );
        },
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


}