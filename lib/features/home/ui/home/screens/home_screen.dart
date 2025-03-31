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

  @override
  Widget build(BuildContext context) {
    DeviceSize deviceSize =DeviceSize(context);
    return MultiBlocProvider(
      providers: [
    BlocProvider<CategoryCubit>(
    create: (context) => getIt<CategoryCubit>()..emitCategoryState(),),
        BlocProvider<BestSellerCubit>(
    create: (context) => getIt<BestSellerCubit>()..emitBestSellerState(),),
        BlocProvider<FavoriteCubit>(
          create: (context) => FavoriteCubit(), // Provide the FavoriteCubit
        ),
      ],
      child: Scaffold(
        body: SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10.h,),
                  SizedBox(
                      height: deviceSize.height*0.3 ,
                      child: const CategoryWidget(),
                  ),
                  SizedBox(
                    height: deviceSize.height*0.35 ,
                    child: const BestSellerWidget(),
                  ),
                  SizedBox(height: 20.h,),

                  SizedBox(
                    height: deviceSize.height*0.35 ,
                    child: const BestSellerWidget(),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
