import 'package:pharmacy/core/network/api_service.dart';
import 'package:pharmacy/core/db/cache/cached_repository_base.dart';
import 'package:pharmacy/core/db/dbHelper/db_constants.dart';

import '../../../../core/models/product/product_response.dart';
import '../../../../core/network/api_result.dart';

class SeeOurProductsRepository extends CachedRepositoryBase {
  final ApiService _apiService;

  SeeOurProductsRepository(this._apiService);

  Future<ApiResult<ProductResponse>> fetchSeeOurProducts({required int page}) async {
    return getCachedPaginatedData<ProductResponse>(
      cacheKey: seeOurProductsCacheKey,
      page: page,
      apiCall: (page) => _apiService.fetchSeeOurProducts(page),
      expiryMs: productsCacheExpiry,
              fromJson: (json) => ProductResponse.fromJson(json),
    );
  }
} 