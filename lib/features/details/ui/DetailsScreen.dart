import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';
import 'package:pharmacy/core/models/product_response.dart';
import 'package:pharmacy/core/themes/text_styles.dart';
import 'package:pharmacy/features/details/logic/details/details_cubit.dart';
import 'package:pharmacy/features/details/logic/product/product_cubit.dart';
import 'package:pharmacy/features/details/logic/product/product_state.dart';
import 'package:pharmacy/gen/colors.gen.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/di/module.dart';
import '../../../core/routes/routes.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/l10n.dart';
import '../../../utils/network_image_utils.dart';
import '../logic/details/details_state.dart';
import '../logic/favorite/favorite_cubit.dart';
import '../logic/favorite/favorite_state.dart';

class DetailScreen extends StatefulWidget {
  final int productId;

  const DetailScreen(this.productId, {super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DetailsCubit>().emitDetailsState(widget.productId);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PharmacyAppBar(
        onSearchTap: () => Navigator.pushNamed(context, Routes.searchScreen),
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {
            if (state is Loading) {
              return const DetailLoading();
            } else if (state is Error) {
              return Center(
                child: Text(
                  'Error: ${state.e}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state is Success) {
              final product = state.data as Results;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 385.h,
                      child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              color:
                                  ColorName.secondaryColor.withOpacity(0.1),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  top: 10, start: 50, end: 50),
                              child: Image.network(
                                  product.productImageUrl ?? "",
                                  fit: BoxFit.cover,
                                  loadingBuilder: loadingBuilder(),
                                  errorBuilder: errorBuilder(
                                      Assets.images.pWatermarkV2.path)),
                            ),
                            // Heart Icon (Top-Right)
                            Positioned(
                              top: 8, // Adjust spacing from the top
                              right: 8, // Adjust spacing from the right
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // Transparent background for the container
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                // Circular shape for the border
                                child:
                                    BlocBuilder<FavoriteCubit, FavoriteState>(
                                  builder: (context, state) {
                                    return IconButton(
                                      icon: Assets.images.heartSvgrepoCom.svg(
                                          colorFilter: ColorFilter.mode(
                                              state.when(
                                                initial: () => Colors.grey,
                                                favorited: () => Colors.red,
                                                notFavorited: () =>
                                                    Colors.grey,
                                              ),
                                              BlendMode.srcIn)),
                                      onPressed: () {
                                        context
                                            .read<FavoriteCubit>()
                                            .toggleFavorite();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            // Container with Text (Top-Left)
                            Visibility(
                              //###if is there
                              visible: true,
                              child: Positioned(
                                top: 8, // Adjust spacing from the top
                                left: 8, // Adjust spacing from the left
                                child: Container(
                                  margin: EdgeInsetsDirectional.only(
                                      top: 5, start: 5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: ColorName.bestSellerBgColor,
                                    borderRadius: BorderRadius.circular(
                                        20), // Rounded corners
                                  ),
                                  child: Text(
                                    S.of(context).best_seller,
                                    // Replace with your dynamic text
                                    style: TextStyles.bestSellerText,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    BlocProvider<ProductCubit>(
                      create: (context) => ProductCubit()
                        ..selectUnit("productUnit1", product.sellPrice!),
                      child: Container(
                        //P.Name/Share/price/discount
                        width: 445.w,
                        margin:
                            EdgeInsetsDirectional.symmetric(horizontal: 8),
                        padding:
                            EdgeInsetsDirectional.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius:
                                BorderRadiusDirectional.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.productNameAr!,
                                  style: TextStyles.productTitles,
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          //baseurl/productID
                                        },
                                        icon: Assets.images.shareSvgrepoCom
                                            .svg()),
                                    Text(
                                      product.amount != 0
                                          ? S.of(context).available
                                          : S.of(context).unavailable,
                                      style: product.amount != 0
                                          ? TextStyles.availabilityText
                                          : TextStyles.unavailabilityText,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Visibility(
                                visible: product.productUnit1_3 !=
                                    product.productUnit1_2,
                                child: MyToggleButtons(
                                  product: product,
                                )),
                            BlocBuilder<ProductCubit, ProductState>(
                              builder: (context, state) {
                                return Text(
                                  "${S.of(context).pound} ${state.price.toInt()}",
                                  // Example content
                                  style: TextStyles.productTitles,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                        //P.Name/Share/price/discount
                        width:445.w,
                        margin:
                            EdgeInsetsDirectional.symmetric(horizontal: 8),
                        padding:
                            EdgeInsetsDirectional.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius:
                                BorderRadiusDirectional.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(S.of(context).details,style: TextStyles.productSubTitles),
                            SizedBox(height: 10.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Text(S.of(context).brandName,style: TextStyles.productDetailTitles,),
                                    Text(product.company?.coNameAr??"",style: TextStyles.productBrandName),
                                  ],
                                ),
                                SizedBox(width: 30.w,),
                                Column(
                                  children: [
                                    Text(S.of(context).unit,style: TextStyles.productDetailTitles),
                                    Text(product.productUnit1??"",style: TextStyles.productUnitName),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h,),
                            Text(S.of(context).productDescription,style: TextStyles.productSubTitles),
                            Text(product.productDescription??'',style: TextStyles.productSubTitles)
                          ],
                        ))
                  ],
                ),
              );
            }
            return const Text("data");
          },
        ),
      ),
    );
  }
}

class MyToggleButtons extends StatelessWidget {
  final Results product;

  const MyToggleButtons({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (BuildContext context, state) {
        print('Rebuilding with state: $state ${state.selectedUnit}');
        return AnimatedToggleSwitch<bool>.size(
            current: state.selectedUnit == 'productUnit2',
            values: const [false, true],
            indicatorSize: const Size.fromWidth(double.infinity),
            customIconBuilder: (context, local, global) => Text(
                  local.value ? product.productUnit2! : product.productUnit1!,
                  style: TextStyles.productTitles,
                ),
            iconAnimationType: AnimationType.onHover,
            style: ToggleStyle(
                indicatorColor: Colors.blue[200],
                borderColor: ColorName.whiteColor,
                borderRadius: BorderRadiusDirectional.circular(15)),
            selectedIconScale: 1,
            onChanged: (value) {
              final selectedUnit = value ? 'productUnit2' : 'productUnit1';
              final price =
                  value ? product.unit2SellPrice! : product.sellPrice!;
              print('Selected Unit: $selectedUnit, Price: $price');
              context.read<ProductCubit>().selectUnit(selectedUnit, price);
            });
      },
    );
  }
}

class DetailLoading extends StatelessWidget {
  const DetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 385,
              width: double.infinity,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 200,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}