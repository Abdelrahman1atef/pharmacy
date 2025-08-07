import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/common_widgets/simple_card_widget.dart';
import 'package:pharmacy/core/common_widgets/header_widget.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';
import 'package:pharmacy/features/items_list/logic/item_list_screen_cubit.dart';
import 'package:pharmacy/features/items_list/logic/item_list_screen_state.dart';
import 'package:pharmacy/utils/device_size.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/models/product/product_response.dart';
import '../../../core/routes/routes.dart';

class ItemListScreen extends StatefulWidget {
  final String widgetTitle;
  final int? categoryId;
  final FetchType? fetchType;
  
  const ItemListScreen({
    super.key, 
    required this.widgetTitle,
    this.categoryId,
    this.fetchType,
  });

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final _scrollController = ScrollController();
  bool _isNearBottom = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<ItemListScreenCubit>().fetchInitialItems(
      categoryId: widget.categoryId,
      fetchType: widget.fetchType,
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    final threshold = maxScroll * 0.8; // Trigger at 80% instead of 90%
    
    // Only trigger once when crossing the threshold
    if (currentScroll >= threshold && !_isNearBottom) {
      _isNearBottom = true;
      context.read<ItemListScreenCubit>().fetchMoreItems();
    } else if (currentScroll < threshold) {
      // Reset when scrolling back up
      _isNearBottom = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PharmacyAppBar(
        onSearchTap: () => Navigator.pushNamed(context, Routes.searchScreen),
      ),
      body: Column(
        children: [
          SizedBox(height: 12.h),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
            child: HeaderWidget(
              widgetTitle: widget.widgetTitle,
              showAllIsVisible: false,
            ),
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: BlocBuilder<ItemListScreenCubit, ItemListScreenState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(child: _ShimmerWidget()),
                  loading: () => GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 300,
                    ),
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
                    itemCount: 4, // Number of shimmer placeholders
                    itemBuilder: (context, index) {
                      return const _ShimmerWidget();
                    },
                  ),
                  loadingFromCache: () => const _CacheLoadingWidget(),
                  loadingMore: (data) => _buildProductList(data, true),
                  success: (data) => _buildProductList(data, false),
                  error: (error, previousData) {
                    if (previousData != null) {
                      return Column(
                        children: [
                          Expanded(child: _buildProductList(previousData, false)),
                          Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Column(
                              children: [
                                Text(
                                  'Error: ${error.message}',
                                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                                ),
                                SizedBox(height: 8.h),
                                ElevatedButton(
                                  onPressed: () => context.read<ItemListScreenCubit>().refreshItems(),
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Error: ${error.message}',
                            style: TextStyle(color: Colors.red, fontSize: 14.sp),
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: () => context.read<ItemListScreenCubit>().fetchInitialItems(
                              categoryId: widget.categoryId,
                              fetchType: widget.fetchType,
                            ),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(ProductResponse data, bool isLoadingMore) {
    DeviceSize deviceSize = DeviceSize(context);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: deviceSize.width > 500 ? 4 : 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 300,
      ),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
      controller: _scrollController,
      // Add key for better performance
      key: const PageStorageKey('product_list'),
      // Optimize item count calculation
      itemCount: data.results.length + (isLoadingMore ? 4 : 0),
      itemBuilder: (context, index) {
        // Show shimmer for loading more items
        if (index >= data.results.length && isLoadingMore) {
          return const _ShimmerWidget();
        }
        
        // Safety check for index bounds
        if (index >= data.results.length) {
          return const SizedBox.shrink();
        }
        
        final product = data.results[index];
        return SimpleCardWidget(
          key: ValueKey('product_${product.productId}'), // Add key for better performance
          product: product,
        );
      },
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
