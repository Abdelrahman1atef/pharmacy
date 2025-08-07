import 'package:pharmacy/core/network/api_service.dart';
import 'package:pharmacy/core/db/cache/cached_repository_base.dart';
import 'package:pharmacy/core/db/dbHelper/db_constants.dart';

import '../../../../core/models/category/category_response.dart';
import '../../../../core/network/api_result.dart';

class CategoryRepository extends CachedRepositoryBase {
  final ApiService _apiService;

  CategoryRepository(this._apiService);

  Future<ApiResult<CategoryResponse>> fetchAllCategory() async {
    return getCachedData<CategoryResponse>(
      cacheKey: categoriesCacheKey,
      apiCall: () => _apiService.fetchAllCategory(),
      expiryMs: categoriesCacheExpiry,
      fromJson: (json) => CategoryResponse.fromJson(json),
    );
  }
}