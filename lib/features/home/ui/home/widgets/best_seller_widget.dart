import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/common_widgets/card_widget.dart';
import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/features/home/logic/best_seller/best_seller_cubit.dart';
import 'package:pharmacy/features/home/logic/best_seller/best_seller_state.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/common_widgets/header_widget.dart';
import '../../../../../generated/l10n.dart';

class BestSellerWidget extends StatelessWidget {
  const BestSellerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          child: Column(
            children: [
              HeaderWidget(
                widgetTitle: S.of(context).best_seller,
                showAllIsVisible: true,
              ),
              SizedBox(
                height: 12.h,
              ),
              SizedBox(
                height: 300.h,
                child: BlocBuilder<BestSellerCubit, BestSellerState>(
                  builder: (context, state) {
                    if (state is Loading) {
                      return const _ShimmerWidget();
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
                            child: CardWidget(product: product),
                          );
                        },
                      );
                    }
                    return const Text("data");
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ShimmerWidget extends StatelessWidget {
  const _ShimmerWidget();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Number of shimmer placeholders
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(end: 0, start: 5),
            child: SizedBox(
              width: 170,
              child: Card(
                color: Colors.grey[300],
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image placeholder
                      Container(
                        height: 120,
                        width: 100,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      // Title placeholder
                      Container(
                        width: 100,
                        height: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      // Price placeholder
                      Container(
                        width: 60,
                        height: 14,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      // Button placeholder
                      Container(
                        width: 120,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
