import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/models/product_response.dart';
import 'package:pharmacy/features/home/logic/best_seller/best_seller_cubit.dart';
import 'package:pharmacy/features/home/logic/best_seller/best_seller_state.dart';

import '../../../../../core/common_widgets/header_widget.dart';
import '../../../../../core/di/module.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/themes/text_styles.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utils/network_image_utils.dart';
import '../../../../details/logic/favorite/favorite_cubit.dart';
import '../../../../details/logic/favorite/favorite_state.dart';

class BestSellerWidget extends StatelessWidget {
  const BestSellerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<BestSellerCubit>()
        ..emitBestSellerState(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
            child: Column(
              children: [
                HeaderWidget(
                  widgetTitle: S
                      .of(context)
                      .best_seller,
                  showAllIsVisible: true,
                ),
                SizedBox(
                  height: 12.h,
                ),
                SizedBox(
                  height: 250.h,
                  child: BlocBuilder<BestSellerCubit, BestSellerState>(
                    builder: (context, state) {
                      if (state is Loading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is Error) {
                        return Center(
                          child: Text(
                            'Error: ${state.e}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      } else if (state is Success) {
                        final products = state.data as ProductResponse;
                        return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: products.results.length,
                          itemBuilder: (BuildContext context, int index) {
                            final product = products.results[index];
                            return Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  end: 0, start: 5),
                              child: InkWell(
                                onTap: () => Navigator.pushNamed(context,Routes.productDetail,arguments: product.productId),
                                child: SizedBox(
                                  width: 170,
                                  child: Card(
                                    color: Colors.grey[300],
                                    shadowColor: ColorName.blackColor,
                                    elevation: 10,
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional
                                          .only(top: 8, bottom: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Stack(
                                              alignment: AlignmentDirectional
                                                  .center,
                                              children: [
                                                SizedBox(
                                                  height: 120,
                                                  width: 100,
                                                  child: Image.network(
                                                      product.productImageUrl ??
                                                          "",
                                                      fit: BoxFit.cover,
                                                      loadingBuilder:
                                                      loadingBuilder(),
                                                      errorBuilder: errorBuilder(
                                                          Assets.images
                                                              .pWatermarkV2
                                                              .path)),
                                                ),
                                                Positioned(
                                                  top: 8,
                                                  right: 8,
                                                  child: Container(
                                                    width: 35.w,
                                                    height: 35.w,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.circular(50),
                                                    ),
                                                    child: BlocBuilder<
                                                        FavoriteCubit,
                                                        FavoriteState>(
                                                      builder: (context, state) {
                                                        return IconButton(
                                                          icon: Assets
                                                              .images
                                                              .heartSvgrepoCom
                                                              .svg(
                                                              colorFilter: ColorFilter
                                                                  .mode(
                                                                  state.when(
                                                                    initial: () =>
                                                                    Colors
                                                                        .grey,
                                                                    favorited:
                                                                        () =>
                                                                    Colors.red,
                                                                    notFavorited:
                                                                        () =>
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
                                                  ),
                                                )
                                              ]),
                                          Text(product.productNameAr!,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyles.productHomeTitles,),
                                          Text(
                                              "${S
                                                  .of(context)
                                                  .pound} ${product.sellPrice
                                                  ?.toInt()}",style: TextStyles.productPriceHomeTitles,),
                                          SizedBox(height: 20,),

                                          Padding(
                                            padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
                                            child: GradientElevatedButton(onPressed: () {

                                            }, text: S.of(context).addToCart),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Text("data");
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GradientElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const GradientElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Adjust border radius
            ),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [ColorName.secondaryColor, ColorName.primaryColor], // Define your gradient colors
            ),
            borderRadius: BorderRadius.circular(30), // Match the border radius
          ),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              text,
              style:  TextStyle(
                color: Colors.white,
                fontFamily: FontFamily.cairo,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//
// Positioned(
// top: 8, // Adjust spacing from the top
// right: 8, // Adjust spacing from the right
// child: Container(
// decoration: BoxDecoration(
// color: Colors.white,
// // Transparent background for the container
// borderRadius: BorderRadius.circular(50),
// ),
// // Circular shape for the border
// child: BlocBuilder<FavoriteCubit,
// FavoriteState>(
// builder: (context, state) {
// return IconButton(
// icon:
// Assets.images.heartSvgrepoCom.svg(
// colorFilter: ColorFilter.mode(
// state.when(
// initial: () =>
// Colors.grey,
// favorited: () =>
// Colors.red,
// notFavorited: () =>
// Colors.grey,
// ),
// BlendMode.srcIn)),
// onPressed: () {
// context
//     .read<FavoriteCubit>()
//     .toggleFavorite();
// },
// );
// },
// ),
// ),
// ),
// // Container with Text (Top-Left)
// Visibility(
// //###if is there
// visible: false,
// child: Positioned(
// top: 8, // Adjust spacing from the top
// left: 8, // Adjust spacing from the left
// child: Container(
// margin: EdgeInsetsDirectional.only(
// top: 5, start: 5),
// padding: const EdgeInsets.symmetric(
// horizontal: 8, vertical: 4),
// decoration: BoxDecoration(
// color: ColorName.bestSellerBgColor,
// borderRadius: BorderRadius.circular(
// 20), // Rounded corners
// ),
// child: Text(
// S.of(context).best_seller,
// // Replace with your dynamic text
// style: TextStyles.bestSellerText,
// ),
// ),
// ),
// ),
