import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common_widgets/header_widget.dart';
import '../../../../../core/common_widgets/simple_card_widget.dart';
import '../../../../../core/themes/text/text_styles.dart';
import '../../../../../features/home/logic/see_our_products/see_our_products_cubit.dart';
import '../../../../../features/home/logic/see_our_products/see_our_products_state.dart';
import '../../../../../generated/l10n.dart';
import '../../../../items_list/logic/item_list_screen_cubit.dart';

class SeeOurProductsWidget extends StatelessWidget {
  const SeeOurProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeeOurProductsCubit, SeeOurProductsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => _buildLoadingWidget(),
          loadingFromCache: () => _buildLoadingWidget(),
          success: (data) => _buildSuccessWidget(context, data),
          error: (message) => _buildErrorWidget(context, message.toString()),
        );
      },
    );
  }

  Widget _buildLoadingWidget() {
    return SizedBox(
      height: 300.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 180.w,
            height: 300.h,
            margin: EdgeInsets.only(right: 10.w),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSuccessWidget(BuildContext context, data) {
    if (data?.results == null || data!.results.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: HeaderWidget(
            widgetTitle: S.of(context).see_our_products,
            showAllIsVisible: true,
            fetchType: FetchType.seeOurProducts,
          ),
        ),
        SizedBox(
          height: 300.h,
          child: ListView.builder(
            key: const PageStorageKey('see_our_products_list'),
            scrollDirection: Axis.horizontal,
            itemCount: data.results.length,
            itemBuilder: (context, index) {
              final product = data.results[index];
              return Container(
                margin: EdgeInsets.only(
                  left: index == 0 ? 16.w : 0,
                  right: index == data.results.length - 1 ? 16.w : 10.w,
                ),
                child: SimpleCardWidget(
                  key: ValueKey('see_our_products_${product.productId}'),
                  product: product,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget(BuildContext context, String message) {
    return Container(
      height: 100.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyles.productHomeTitles.copyWith(
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            ElevatedButton(
              onPressed: () {
                context.read<SeeOurProductsCubit>().refreshSeeOurProducts();
              },
              child: Text(S.of(context).retry),
            ),
          ],
        ),
      ),
    );
  }
} 