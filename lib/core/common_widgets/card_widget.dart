import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/models/product_response.dart';
import 'package:pharmacy/features/cart/data/cart_crud.dart';
import 'package:pharmacy/features/cart/data/model/product.dart';

import '../../features/details/logic/favorite/favorite_cubit.dart';
import '../../features/details/logic/favorite/favorite_state.dart';
import '../../gen/assets.gen.dart';
import '../../gen/colors.gen.dart';
import '../../generated/l10n.dart';
import '../../utils/network_image_utils.dart';
import '../themes/text_styles.dart';
import 'gradient_button.dart';

class CardWidget extends StatelessWidget {
 final Results product;
 final bool itemListSize;
  const CardWidget({super.key, required this.product,  this.itemListSize=false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180.w,
      height: 300.h,//300for normal
      child: Card(
        color: ColorName.whiteColor,
        shadowColor: ColorName.blackColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              12), // Rounded corners
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Stack(
                      alignment:
                      AlignmentDirectional.topStart,
                      children: [
                        SizedBox(
                          height: 120.h,
                          width: double.infinity,
                          child: Image.network(
                              product.productImageUrl ??
                                  "",
                              fit: BoxFit.cover,
                              loadingBuilder:
                              loadingBuilder(),
                              errorBuilder:
                              errorBuilder(Assets
                                  .images
                                  .pWatermarkV2
                                  .path)),
                        ),
                        Container(
                          width: 32.w,
                          height: 32.w,
                          decoration:
                          const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: BlocBuilder<
                              FavoriteCubit,
                              FavoriteState>(
                            builder: (context, state) {
                              return IconButton(
                                icon: Assets.images
                                    .heartSvgrepoCom
                                    .svg(
                                    width: 16.w,
                                    height: 16.w,
                                    colorFilter: ColorFilter
                                        .mode(
                                        state
                                            .when(
                                          initial: () =>
                                          Colors.grey,
                                          favorited: () =>
                                          Colors.red,
                                          notFavorited: () =>
                                          Colors.grey,
                                        ),
                                        BlendMode
                                            .srcIn)),
                                onPressed: () {
                                  context
                                      .read<
                                      FavoriteCubit>()
                                      .toggleFavorite();
                                },
                              );
                            },
                          ),
                        )
                      ]),
                  SizedBox(height: 12.h),
                  Text(
                    product.productNameAr!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.productHomeTitles,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "${S.of(context).pound} ${product.sellPrice?.toInt()}",
                    style: TextStyles
                        .productPriceHomeTitles,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),

                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional
                    .symmetric(horizontal: 5),
                child: GradientElevatedButton(
                    onPressed: () {
                     CartCrud.crud.create(product.toProduct());
                     print("""
                     ${product.toProduct()}
                     """);
                    },
                    text: S.of(context).addToCart),
              )
            ],
          ),
        ),
      ),
    );
  }
}


