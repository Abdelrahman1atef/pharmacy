// lib/app_bloc_providers.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/core/di/module.dart';
import 'package:pharmacy/features/admin/orders/logic/admin_orders_cubit.dart';
import 'package:pharmacy/features/cart/logic/cart/cart_cubit.dart';
import 'package:pharmacy/features/cart/logic/order/order_cubit.dart';
import 'package:pharmacy/features/login&signup/logic/signup/signup_cubit.dart';
import 'package:pharmacy/features/main/logic/main_cubit.dart';
import 'package:pharmacy/features/user_orders/logic/user_orders_cubit.dart';

import 'app_config_provider/logic/auth/logic/auth_cubit.dart';
import 'app_config_provider/logic/internet_server_connection/logic/internet_server_connection_cubit.dart';
import 'features/checkout/logic/location/location_cubit.dart';
import 'features/checkout/logic/payment/payment_cubit.dart';
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
        BlocProvider(create: (_) => getIt<InternetServerConnectionCubit>()),
        BlocProvider(create: (_) => getIt<AuthCubit>()),
        BlocProvider(create: (_)=>MainCubit()),
        BlocProvider(create: (_) => getIt<SearchCubit>()),
        BlocProvider(create: (_) => getIt<DetailsCubit>()),
        BlocProvider(create: (_) => getIt<BestSellerCubit>()),
        BlocProvider(create: (_) => getIt<CategoryCubit>()),
        BlocProvider(create: (_) => FavoriteCubit()),
        BlocProvider(create: (_) => getIt<ItemListScreenCubit>()),
        BlocProvider(create: (_)=> getIt<CartCubit>()),
        BlocProvider(create: (_)=> getIt<OrderCubit>()),
        BlocProvider(create: (_)=> LoginScreenCubit()),
        BlocProvider(create: (_)=> getIt<SignupCubit>()),
        BlocProvider(create: (_)=> getIt<AdminOrdersCubit>()),
        BlocProvider(create: (_)=> getIt<UserOrdersCubit>()),
        BlocProvider(create: (_)=> PaymentCubit()),
        BlocProvider(create: (_)=> LocationCubit()),
      ],
      child: child,
    );
  }
}