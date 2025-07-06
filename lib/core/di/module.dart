import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmacy/app_config_provider/logic/internet_server_connection/repository/internet_server_connection_repository.dart';
import 'package:pharmacy/features/admin/dashboard/data/repository/dashboard_repository.dart';
import 'package:pharmacy/features/admin/dashboard/logic/dashboard_cubit.dart';
import 'package:pharmacy/features/admin/orders/logic/admin_orders_cubit.dart';
import 'package:pharmacy/features/admin/orders/repository/orders_repository.dart';
import 'package:pharmacy/features/cart/logic/cart/cart_cubit.dart';
import 'package:pharmacy/features/cart/logic/order/order_cubit.dart';
import 'package:pharmacy/features/cart/repository/cart_repository.dart';
import 'package:pharmacy/features/cart/repository/order_repository.dart';
import 'package:pharmacy/features/details/logic/details/details_cubit.dart';
import 'package:pharmacy/features/details/repository/details_repository.dart';
import 'package:pharmacy/features/home/logic/best_seller/best_seller_cubit.dart';
import 'package:pharmacy/features/home/logic/category/category_cubit.dart';
import 'package:pharmacy/features/home/logic/see_our_products/see_our_products_cubit.dart';
import 'package:pharmacy/features/home/repository/best_seller/best_seller_repository.dart';
import 'package:pharmacy/features/home/repository/category/category_repository.dart';
import 'package:pharmacy/features/home/repository/see_our_products/see_our_products_repository.dart';
import 'package:pharmacy/features/items_list/logic/item_list_screen_cubit.dart';
import 'package:pharmacy/features/items_list/repository/item_list/item_list_repository.dart';
import 'package:pharmacy/features/login&signup/logic/signup/signup_cubit.dart';
import 'package:pharmacy/features/login&signup/repository/signup_repository.dart';
import 'package:pharmacy/features/user_orders/logic/user_orders_cubit.dart';
import 'package:pharmacy/features/user_orders/repository/user_orders_repository.dart';
import 'package:pharmacy/features/admin/users/logic/admin_users/admin_users_cubit.dart';
import 'package:pharmacy/features/admin/users/logic/admin_user_detail/admin_user_detail_cubit.dart';
import 'package:pharmacy/features/admin/users/repository/admin_users_repository.dart';
import 'package:pharmacy/features/admin/users/repository/admin_user_detail_repository.dart';

import '../../app_config_provider/logic/auth/logic/auth_cubit.dart';
import '../../app_config_provider/logic/auth/repository/auth_repository.dart';
import '../../app_config_provider/logic/internet_server_connection/logic/internet_server_connection_cubit.dart';
import '../../features/search/logic/search_cubit.dart';
import '../../features/search/repository/search_repository.dart';
import '../db/cart/cart_crud.dart';
import '../db/dbHelper/db_helper.dart';
import '../network/api_service.dart';
import '../network/dio_config.dart';


GetIt getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<DbHelper>(() => DbHelper());
  getIt.registerLazySingleton<CartCrud>(()=>CartCrud(getIt()));
  getIt.registerLazySingleton<Dio>(() => DioConfig.getDio());
  getIt.registerLazySingleton<ApiService>(() => ApiServiceImpl(getIt()));
  getIt.registerFactory<SearchRepository>(() => SearchRepository(getIt()));
  getIt.registerFactory<DetailsRepository>(() => DetailsRepository(getIt()));
  getIt.registerFactory<CategoryRepository>(() => CategoryRepository(getIt()));
  getIt.registerFactory<BestSellerRepository>(() => BestSellerRepository(getIt()));
  getIt.registerFactory<SeeOurProductsRepository>(() => SeeOurProductsRepository(getIt()));
  getIt.registerFactory<ItemListRepository>(() => ItemListRepository(getIt()));
  getIt.registerFactory<CartRepository>(() => CartRepository(getIt()));
  getIt.registerFactory<SignupRepository>(() => SignupRepository(getIt()));
  getIt.registerFactory<AuthRepository>(() => AuthRepository(getIt()));
  getIt.registerFactory<InternetServerConnectionRepository>(() => InternetServerConnectionRepository(getIt()));
  getIt.registerFactory<OrderRepository>(() => OrderRepository(getIt()));
  getIt.registerFactory<AdminOrdersRepository>(() => AdminOrdersRepository(getIt()));
  getIt.registerFactory<UserOrdersRepository>(() => UserOrdersRepository(getIt()));
  getIt.registerFactory<AdminUsersRepository>(() => AdminUsersRepositoryImpl(getIt()));
  getIt.registerFactory<AdminUserDetailRepository>(() => AdminUserDetailRepositoryImpl(getIt()));
  getIt.registerFactory<DashboardRepository>(() => DashboardRepository(getIt()));

  getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt()));
  getIt.registerFactory<DetailsCubit>(() => DetailsCubit(getIt()));
  getIt.registerFactory<CategoryCubit>(() => CategoryCubit(getIt()));
  getIt.registerFactory<BestSellerCubit>(() => BestSellerCubit(getIt()));
  getIt.registerFactory<SeeOurProductsCubit>(() => SeeOurProductsCubit(getIt()));
  getIt.registerFactory<ItemListScreenCubit>(() => ItemListScreenCubit(getIt()));
  getIt.registerFactory<CartCubit>(() => CartCubit(getIt()));
  getIt.registerFactory<OrderCubit>(() => OrderCubit(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));
  getIt.registerFactory<InternetServerConnectionCubit>(() => InternetServerConnectionCubit(Connectivity(),getIt()));
  getIt.registerFactory<AdminOrdersCubit>(() => AdminOrdersCubit(getIt()));
  getIt.registerFactory<UserOrdersCubit>(() => UserOrdersCubit(getIt()));
  getIt.registerFactory<AdminUsersCubit>(() => AdminUsersCubit(getIt()));
  getIt.registerFactory<AdminUserDetailCubit>(() => AdminUserDetailCubit(getIt()));
  getIt.registerFactory<DashboardCubit>(() => DashboardCubit(getIt()));

}