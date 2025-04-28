// lib/app_bloc_providers.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/core/di/module.dart';
import 'package:pharmacy/features/cart/logic/cart_cubit.dart';
import 'package:pharmacy/features/login&signup/logic/signup/signup_cubit.dart';

import 'features/details/logic/details/details_cubit.dart';
import 'features/details/logic/favorite/favorite_cubit.dart';
import 'features/home/logic/best_seller/best_seller_cubit.dart';
import 'features/home/logic/category/category_cubit.dart';
import 'features/items_list/logic/item_list_screen_cubit.dart';
import 'features/login&signup/logic/login/login_cubit.dart';
import 'features/search/logic/search_cubit.dart';

class AppBlocProviders extends StatelessWidget {
  final Widget child;

  const AppBlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<SearchCubit>()),
        BlocProvider(create: (_) => getIt<DetailsCubit>()),
        BlocProvider(create: (_) => getIt<BestSellerCubit>()),
        BlocProvider(create: (_) => getIt<CategoryCubit>()),
        BlocProvider(create: (_) => FavoriteCubit()),
        BlocProvider(create: (_) => getIt<ItemListScreenCubit>()),
        BlocProvider(create: (_)=> getIt<CartCubit>()),
        BlocProvider(create: (_)=> LoginScreenCubit()),
        BlocProvider(create: (_)=> getIt<SignupCubit>()),
      ],
      child: child,
    );
  }
}