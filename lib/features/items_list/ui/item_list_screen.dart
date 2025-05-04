import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/common_widgets/card_widget.dart';
import 'package:pharmacy/core/common_widgets/header_widget.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';
import 'package:pharmacy/features/items_list/logic/item_list_screen_cubit.dart';
import 'package:pharmacy/features/items_list/logic/item_list_screen_state.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/models/product/product_response.dart';
import '../../../core/routes/routes.dart';

class ItemListScreen extends StatefulWidget {
  final String widgetTitle;
  final int? categoryId;
  const ItemListScreen({super.key, required this.widgetTitle,this.categoryId});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<ItemListScreenCubit>().fetchInitialItems(categoryId: widget.categoryId);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<ItemListScreenCubit>().fetchMoreItems();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PharmacyAppBar(
        onSearchTap: () => Navigator.pushNamed(context, Routes.searchScreen),
      ),
      body: Column(
        children: [
          SizedBox(height: 12.h,),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
            child: HeaderWidget(widgetTitle:widget.widgetTitle,showAllIsVisible: false,),
          ),
          SizedBox(height: 12.h,),
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
                      return const _ShimmerWidget(); // Full grid of shimmer placeholders
                    },
                  ),
                  loadingMore: (data) => _buildProductList(data, true),
                  success: (data) => _buildProductList(data, false),
                  error: (error, previousData) {
                    if (previousData != null) {
                      return Column(
                        children: [
                          Expanded(child: _buildProductList(previousData, false)),
                          ElevatedButton(
                            onPressed: () => context.read<ItemListScreenCubit>().fetchInitialItems(),
                            child: const Text('Retry'),
                          ),
                        ],
                      );
                    }
                    return Center(child: Text('Error: ${error.message}'));
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
    return GridView.builder(
      gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 300,
      ),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),

      controller: _scrollController,
      itemCount: data.results.length + (isLoadingMore ? 4 : 0),
      itemBuilder: (context, index) {
        if (index >= data.results.length && isLoadingMore) {
          return const _ShimmerWidget();
        }
        final product = data.results[index];
        return CardWidget(product: product);
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
      child:
           Padding(
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
           )


    );
  }
}
