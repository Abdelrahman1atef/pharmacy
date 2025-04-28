import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmacy/core/controller/network_controller.dart';
import 'package:pharmacy/features/cart/logic/cart_cubit.dart';
import 'package:pharmacy/features/cart/repository/cart_repository.dart';
import 'package:pharmacy/features/details/logic/details/details_cubit.dart';
import 'package:pharmacy/features/details/repository/details_repository.dart';
import 'package:pharmacy/features/home/logic/best_seller/best_seller_cubit.dart';
import 'package:pharmacy/features/home/logic/category/category_cubit.dart';
import 'package:pharmacy/features/home/repository/best_seller/best_seller_repository.dart';
import 'package:pharmacy/features/home/repository/category/category_repository.dart';
import 'package:pharmacy/features/items_list/logic/item_list_screen_cubit.dart';
import 'package:pharmacy/features/items_list/repository/item_list/item_list_repository.dart';
import 'package:pharmacy/features/login&signup/logic/signup/signup_cubit.dart';
import 'package:pharmacy/features/login&signup/repository/signup_repository.dart';

import '../../features/search/logic/search_cubit.dart';
import '../../features/search/repository/search_repository.dart';
import '../db/cart/cart_crud.dart';
import '../db/dbHelper/db_helper.dart';
import '../network/api_service.dart';
import '../network/dio_config.dart';


GetIt getIt = GetIt.instance;

void setupDependencies() {
  Get.put<NetworkController>(NetworkController(),permanent: true);
  getIt.registerLazySingleton<DbHelper>(() => DbHelper());
  getIt.registerLazySingleton<CartCrud>(()=>CartCrud(getIt()));
  getIt.registerLazySingleton<Dio>(() => DioConfig.getDio());
  getIt.registerLazySingleton<ApiService>(() => ApiServiceImpl(getIt()));
  getIt.registerFactory<SearchRepository>(() => SearchRepository(getIt()));
  getIt.registerFactory<DetailsRepository>(() => DetailsRepository(getIt()));
  getIt.registerFactory<CategoryRepository>(() => CategoryRepository(getIt()));
  getIt.registerFactory<BestSellerRepository>(() => BestSellerRepository(getIt()));
  getIt.registerFactory<ItemListRepository>(() => ItemListRepository(getIt()));
  getIt.registerFactory<CartRepository>(() => CartRepository(getIt()));
  getIt.registerFactory<SignupRepository>(() => SignupRepository(getIt()));
  getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt()));
  getIt.registerFactory<DetailsCubit>(() => DetailsCubit(getIt()));
  getIt.registerFactory<CategoryCubit>(() => CategoryCubit(getIt()));
  getIt.registerFactory<BestSellerCubit>(() => BestSellerCubit(getIt()));
  getIt.registerFactory<ItemListScreenCubit>(() => ItemListScreenCubit(getIt()));
  getIt.registerFactory<CartCubit>(() => CartCubit(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));
}