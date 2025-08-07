import 'package:pharmacy/core/network/api_service.dart';
import 'package:pharmacy/core/db/cache/cached_repository_base.dart';
import 'package:pharmacy/core/db/dbHelper/db_constants.dart';

import '../../../../core/models/product/product_response.dart';
import '../../../../core/network/api_result.dart';

class ItemListRepository extends CachedRepositoryBase {
  final ApiService _apiService;

  ItemListRepository(this._apiService);

  Future<ApiResult<ProductResponse>> fetchAllProduct({required int page}) async {
    return getCachedPaginatedData<ProductResponse>(
      cacheKey: allProductsCacheKey,
      page: page,
      apiCall: (page) => _apiService.fetchAllProduct(page),
      expiryMs: productsCacheExpiry,
      fromJson: (json) => ProductResponse.fromJson(json),
    );
  }
  
  Future<ApiResult<ProductResponse>> fetchBestSellers({required int page}) async {
    return getCachedPaginatedData<ProductResponse>(
      cacheKey: bestSellersCacheKey,
      page: page,
      apiCall: (page) => _apiService.fetchBestSellers(page),
      expiryMs: bestSellersCacheExpiry,
      fromJson: (json) => ProductResponse.fromJson(json),
    );
  }
  
  Future<ApiResult<ProductResponse>> fetchSeeOurProducts({required int page}) async {
    return getCachedPaginatedData<ProductResponse>(
      cacheKey: seeOurProductsCacheKey,
      page: page,
      apiCall: (page) => _apiService.fetchSeeOurProducts(page),
      expiryMs: productsCacheExpiry,
      fromJson: (json) => ProductResponse.fromJson(json),
    );
  }
  
  Future<ApiResult<ProductResponse>> fetchProductByCategory({required int page, required int categoryId}) async {
    final cacheKey = '$productsByCategoryCacheKey$categoryId';
    return getCachedPaginatedData<ProductResponse>(
      cacheKey: cacheKey,
      page: page,
      apiCall: (page) => _apiService.fetchProductByCategory(categoryId: categoryId, page: page),
      expiryMs: productsCacheExpiry,
      fromJson: (json) => ProductResponse.fromJson(json),
    );
  }
}