import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/features/details/logic/favorite/favorite_cubit.dart';
import 'package:pharmacy/features/home/logic/best_seller/best_seller_cubit.dart';
import 'package:pharmacy/utils/device_size.dart';

import '../../../../../core/di/module.dart';
import '../../../logic/category/category_cubit.dart';
import '../widgets/best_seller_widget.dart';
import '../widgets/category_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  Future<void> _onRefresh(BuildContext context) async {
    await Future.wait([
      Future(() => context.read<CategoryCubit>().emitCategoryState()),
      Future(() => context.read<BestSellerCubit>().emitBestSellerState()),
    ]);
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
                  SizedBox(height: 10.h,),
                  SizedBox(
                      height: 260.h ,
                      child: const CategoryWidget(),
                  ),
                  SizedBox(
                    height: 340.h ,
                    child: const BestSellerWidget(),
                  ),
                  SizedBox(height: 20.h,),

                  SizedBox(
                    height: 340.h ,
                    child: const BestSellerWidget(),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
