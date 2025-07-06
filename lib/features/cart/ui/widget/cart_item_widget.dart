import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/common_widgets/quantity_selector.dart';
import 'package:pharmacy/core/db/cart/model/product.dart';
import 'package:pharmacy/features/cart/logic/cart/cart_cubit.dart';
import 'package:pharmacy/gen/colors.gen.dart';

import '../../../../core/themes/text/text_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/network_image_utils.dart';

class CartItemWidget extends StatelessWidget {
  final Product product;

  const CartItemWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: ColorName.whiteColor,
      margin: const EdgeInsetsDirectional.all(12),
      child: Padding(
        padding: const EdgeInsetsDirectional.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Card(
                    child: SizedBox(
                      width: 100.w,
                      height: 100.h,
                      child: Image.network(
                        (product.productImages != null && product.productImages!.isNotEmpty)
                            ? product.productImages![0]
                            : "",
                        fit: BoxFit.cover,
                        loadingBuilder: loadingBuilder(),
                        errorBuilder: errorBuilder(Assets.images.pWatermarkV2.path),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                
                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name and Remove Button
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              product.productNameAr ?? "",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.productHomeTitles,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          InkWell(
                            onTap: () => showConfirmationDialog(context, product),
                            child: Assets.images.remove.svg(
                              colorFilter: const ColorFilter.mode(
                                ColorName.productDetailTextColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 12.h),
                      
                      // Product Unit and Price
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.selectedUnitType ?? "",
                            style: TextStyles.cartProductType,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "${S.of(context).pound} ${product.selectedUnitPrice}",
                            style: TextStyles.cartProductPrice,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16.h),
            
            // Quantity Selector
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 160.w,
                child: QuantitySelector(
                  product: product,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  static void showConfirmationDialog(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      elevation: 5,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(70), topEnd: Radius.circular(70))),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text.rich(
                TextSpan(
                  text:
                  "${S.of(context).deleteCartItemAlertP1} ", // First part of the text
                  style: TextStyles.productHomeTitles, // Base style
                  children: [
                    TextSpan(
                        text: product.productNameAr, // The dynamic product name
                        style: TextStyles.productHomeTitles
                            .copyWith(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text:
                      " ${S.of(context).deleteCartItemAlertP2}", // Second part of the text
                      style: TextStyles.productHomeTitles, // Revert to base style
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<CartCubit>().deleteCartItem(product.productId);
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    child: Text(
                      S.of(context).deleteCartItem,
                      style: TextStyles.cartConfirmationDialog.copyWith(
                          color: ColorName.errorTextColor
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      S.of(context).keepCartItem,
                      style: TextStyles.cartConfirmationDialog.copyWith(
                          color: ColorName.secondaryColor
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}


