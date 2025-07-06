import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:pharmacy/gen/assets.gen.dart';
import 'package:pharmacy/generated/l10n.dart';
import '../widgets/product_unit_toggle.dart';
import '../../logic/product/product_cubit.dart';
import '../../logic/product/product_state.dart';

class ProductInfoSection extends StatefulWidget {
  final Results product;

  const ProductInfoSection({
    super.key,
    required this.product,
  });

  @override
  State<ProductInfoSection> createState() => _ProductInfoSectionState();
}

class _ProductInfoSectionState extends State<ProductInfoSection> {

  @override
  void initState() {
    context.read<ProductCubit>().selectUnit("productUnit1", widget.product.sellPrice!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final isAvailable = widget.product.amount != 0;
    return Container(
      width: 445.w,
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 8),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadiusDirectional.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product name and availability
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  widget.product.productNameAr!,
                  style: TextStyles.productTitles,
                ),
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      // TODO: Implement share functionality
                    },
                    icon: Assets.images.share.svg(),
                  ),
                  Text(
                    isAvailable
                        ? S.of(context).available
                        : S.of(context).unavailable,
                    style: isAvailable
                        ? TextStyles.availabilityText
                        : TextStyles.unavailabilityText,
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 5.h),

          // Unit toggle (if multiple units available)
          Visibility(
            visible: widget.product.productUnit1_3 != widget.product.productUnit1_2,
            child: ProductUnitToggle(product: widget.product),
          ),

          // Price display
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              return Text(
                "${S.of(context).pound} ${state.price.toInt()}",
                style: TextStyles.productTitles,
              );
            },
          ),
        ],
      ),
    );
  }
}