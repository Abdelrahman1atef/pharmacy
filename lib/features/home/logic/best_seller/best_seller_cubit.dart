import 'package:pharmacy/core/db/cache/cached_cubit_base.dart';
import 'package:pharmacy/core/db/dbHelper/db_constants.dart';
import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/features/home/repository/best_seller/best_seller_repository.dart';

import 'best_seller_state.dart';

class BestSellerCubit extends CachedCubitBase<BestSellerState> {
  final BestSellerRepository _bestSellerRepository;
  
  BestSellerCubit(this._bestSellerRepository) : super(const Initial());

  void emitBestSellerState() {
    emit(const Loading());
    
    loadCachedData<ProductResponse>(
      cacheKey: '${bestSellersCacheKey}_page_1',
      apiCall: () => _bestSellerRepository.fetchBestSellers(page: 1),
      onSuccess: (ProductResponse data) => emit(Success(data)),
      onError: (error) => emit(Error(error)),
    );
  }

  /// Clear best sellers cache and refresh
  Future<void> refreshBestSellers() async {
    await clearCache('${bestSellersCacheKey}_page_1');
    emitBestSellerState();
  }
}
