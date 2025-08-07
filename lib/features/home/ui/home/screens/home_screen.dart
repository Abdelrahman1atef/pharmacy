import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/features/home/logic/best_seller/best_seller_cubit.dart';
import 'package:pharmacy/features/home/logic/see_our_products/see_our_products_cubit.dart';

import '../../../logic/category/category_cubit.dart';
import '../widgets/best_seller_widget.dart';
import '../widgets/category_widget.dart';
import '../widgets/see_our_products_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _onRefresh(BuildContext context) async {
    // Refresh all data with cache invalidation
    await Future.wait([
      Future(() => context.read<CategoryCubit>().refreshCategories()),
      Future(() => context.read<BestSellerCubit>().refreshBestSellers()),
      Future(() => context.read<SeeOurProductsCubit>().refreshSeeOurProducts()),
    ]);
  }

  @override
  void initState() {
    super.initState();
    // Delay fetch until after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryCubit>().emitCategoryState();
      context.read<BestSellerCubit>().emitBestSellerState();
      context.read<SeeOurProductsCubit>().emitSeeOurProductsState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: RefreshIndicator(
          onRefresh: () => _onRefresh(context),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(), // Required for RefreshIndicator
            child: Column(
              children: [
                SizedBox(height: 10.h),
                const CategoryWidget(),
                SizedBox(height: 20.h),
                const BestSellerWidget(),
                SizedBox(height: 20.h),
                const SeeOurProductsWidget(),
                // Add extra space to ensure pull-to-refresh works
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
