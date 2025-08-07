import 'package:pharmacy/core/network/api_service.dart';
import 'package:pharmacy/core/db/cache/cached_repository_base.dart';
import 'package:pharmacy/core/db/dbHelper/db_constants.dart';

import '../../../../core/models/product/product_response.dart';
import '../../../../core/network/api_result.dart';

class BestSellerRepository extends CachedRepositoryBase {
  final ApiService _apiService;

  BestSellerRepository(this._apiService);

  Future<ApiResult<ProductResponse>> fetchBestSellers({required int page}) async {
    return getCachedPaginatedData<ProductResponse>(
      cacheKey: bestSellersCacheKey,
      page: page,
      apiCall: (page) => _apiService.fetchBestSellers(page),
      expiryMs: bestSellersCacheExpiry,
              fromJson: (json) => ProductResponse.fromJson(json),
    );
  }
}