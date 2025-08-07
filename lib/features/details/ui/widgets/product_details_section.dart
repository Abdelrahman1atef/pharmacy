import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:pharmacy/generated/l10n.dart';

class ProductDetailsSection extends StatelessWidget {
  final Results product;

  const ProductDetailsSection({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 445.w,
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 8),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadiusDirectional.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).details,
              style: TextStyles.productSubTitles,
            ),
            
            SizedBox(height: 10.h),
            
            // Brand and Unit information
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).brandName,
                      style: TextStyles.productDetailTitles,
                    ),
                    Text(
                      product.company?.coNameAr ?? "",
                      style: TextStyles.productBrandName,
                    ),
                  ],
                ),
                
                SizedBox(width: 30.w),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).unit,
                      style: TextStyles.productDetailTitles,
                    ),
                    Text(
                      product.productUnit1 ?? "",
                      style: TextStyles.productUnitName,
                    ),
                  ],
                ),
              ],
            ),
            
            SizedBox(height: 15.h),
            
            // Product description
            Text(
              S.of(context).productDescription,
              style: TextStyles.productSubTitles,
            ),
            Text(
              product.productDescription?.pdNameAr ?? '',
              style: TextStyles.productSubTitles,
            ),
          ],
        ),
      ),
    );
  }
} 