import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/common_widgets/card_widget.dart';
import 'package:pharmacy/core/common_widgets/header_widget.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';
import 'package:pharmacy/features/items_list/logic/item_list_screen_cubit.dart';
import 'package:pharmacy/features/items_list/logic/item_list_screen_state.dart';

import '../../../core/models/product_response.dart';

class ItemListScreen extends StatefulWidget {
  final String widgetTitle;
  const ItemListScreen({super.key, required this.widgetTitle});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<ItemListScreenCubit>().fetchInitialItems();
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
      appBar: const PharmacyAppBar(),
      body: Column(
        children: [
          SizedBox(height: 12.h,),
          HeaderWidget(widgetTitle:widget.widgetTitle,showAllIsVisible: false,),
          SizedBox(height: 12.h,),
          Expanded(
            child: BlocBuilder<ItemListScreenCubit, ItemListScreenState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(child: CircularProgressIndicator()),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  loadingMore: (data) => _buildProductList(data, true),
                  success: (data) => _buildProductList(data, false),
                  error: (error, previousData) {
                    if (previousData != null) {
                      return Column(
                        children: [
                          Expanded(child: _buildProductList(previousData, false)),
                          Center(child: Text('Error: ${error.message}')),
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
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 30,

      ),
      controller: _scrollController,
      itemCount: isLoadingMore ? data.results.length + 1 : data.results.length,
      itemBuilder: (context, index) {
        if (index >= data.results.length) {
          return const Center(child: CircularProgressIndicator());
        }
        final product = data.results[index];
        return CardWidget(product: product);
      },
    );
  }
}
