import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/routes/routes.dart';
import 'package:pharmacy/features/home/logic/category/category_cubit.dart';
import 'package:pharmacy/features/home/logic/category/category_state.dart';
import 'package:pharmacy/gen/assets.gen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/common_widgets/header_widget.dart';
import '../../../../../core/models/category/category_response.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utils/network_image_utils.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = (screenWidth ~/ 90).clamp(2, 6);
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
      child: Column(
        children: [
          HeaderWidget(
            widgetTitle: S.of(context).titles_category,
            showAllIsVisible: false,
          ),
          SizedBox(
            height: 12.h,
          ),
          BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              return state.when(
                initial: () => const _ShimmerWidget(),
                loading: () => const _ShimmerWidget(),
                loadingFromCache: () => const _CacheLoadingWidget(),
                                 success: (data) {
                   final categoriesResponse = data as CategoryResponse;
                   final categories = categoriesResponse.results;
                   return GridView.builder(
                     shrinkWrap: true,
                     physics: const NeverScrollableScrollPhysics(),
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: crossAxisCount,
                       mainAxisSpacing: 8.w,
                       crossAxisSpacing: 8.w,
                       childAspectRatio: 1,
                     ),
                     itemCount: categories?.length ?? 0,
                     itemBuilder: (BuildContext context, int index) {
                       final category = categories?[index];
                      return InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          Routes.itemListScreen,
                          arguments: category,
                        ),
                        child: Card(
                          elevation: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 30.h,
                                width: 20.w,
                                child: Image.network(
                                  "",
                                  fit: BoxFit.cover,
                                  loadingBuilder: loadingBuilder(),
                                  errorBuilder: (context, error, stackTrace) =>
                                      Assets.images.categoryDefaultIcon.svg(),
                                ),
                              ),
                              Flexible(
                                                                 child: Text(
                                   category?.categoryNameAr ?? "",
                                   textAlign: TextAlign.center,
                                   maxLines: 2,
                                   overflow: TextOverflow.ellipsis,
                                   style: TextStyle(fontSize: 12.sp),
                                 ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                error: (error) => Center(
                  child: Column(
                    children: [
                      Text(
                        'Error: ${error.message}',
                        style: TextStyle(color: Colors.red, fontSize: 14.sp),
                      ),
                      SizedBox(height: 8.h),
                      ElevatedButton(
                        onPressed: () => context.read<CategoryCubit>().refreshCategories(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ShimmerWidget extends StatelessWidget {
  const _ShimmerWidget();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = (screenWidth ~/ 90).clamp(2, 6);
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 8.w,
          crossAxisSpacing: 8.w,
          childAspectRatio: 0.7,
        ),
        itemCount: 8, // Show 8 shimmer items
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30.h,
                  width: 20.w,
                  color: Colors.white,
                ),
                SizedBox(height: 8.h),
                Container(
                  width: 60,
                  height: 12,
                  color: Colors.white,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CacheLoadingWidget extends StatelessWidget {
  const _CacheLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 16.w,
            height: 16.w,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[400]!),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            'Loading from cache...',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.blue[600],
            ),
          ),
        ],
      ),
    );
  }
}

