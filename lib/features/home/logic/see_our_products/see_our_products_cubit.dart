import 'package:pharmacy/core/db/cache/cached_cubit_base.dart';
import 'package:pharmacy/core/db/dbHelper/db_constants.dart';
import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/features/home/repository/see_our_products/see_our_products_repository.dart';

import 'see_our_products_state.dart';

class SeeOurProductsCubit extends CachedCubitBase<SeeOurProductsState> {
  final SeeOurProductsRepository _seeOurProductsRepository;
  
  SeeOurProductsCubit(this._seeOurProductsRepository) : super(const Initial());

  void emitSeeOurProductsState() {
    emit(const Loading());
    
    loadCachedData<ProductResponse>(
      cacheKey: '${seeOurProductsCacheKey}_page_1',
      apiCall: () => _seeOurProductsRepository.fetchSeeOurProducts(page: 1),
      onSuccess: (ProductResponse data) => emit(Success(data)),
      onError: (error) => emit(Error(error)),
    );
  }

  /// Clear see our products cache and refresh
  Future<void> refreshSeeOurProducts() async {
    await clearCache('${seeOurProductsCacheKey}_page_1');
    emitSeeOurProductsState();
  }
} 