import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmacy/features/details/logic/details_cubit.dart';
import 'package:pharmacy/features/details/repository/details_repository.dart';

import '../../features/search/logic/search_cubit.dart';
import '../../features/search/repository/search_repository.dart';
import '../network/api_service.dart';
import '../network/dio_config.dart';


GetIt getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<Dio>(() => DioConfig.getDio());
  getIt.registerLazySingleton<ApiService>(() => ApiServiceImpl(getIt()));
  getIt.registerFactory<SearchRepository>(() => SearchRepository(getIt()));
  getIt.registerFactory<DetailsRepository>(() => DetailsRepository(getIt()));
  getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt()));
  getIt.registerFactory<DetailsCubit>(() => DetailsCubit(getIt()));
  // getIt.registerFactory<CastCubit>(() => CastCubit(getIt()));
  // getIt.registerFactory<TrailerCubit>(() => TrailerCubit(getIt()));
}