import 'package:pharmacy/core/network/api_service.dart';
import 'package:pharmacy/core/network/api_result.dart';
import 'package:pharmacy/core/network/api_exception.dart';
import 'package:pharmacy/core/models/category/category_response.dart';
import 'package:pharmacy/core/db/cache/cache_service.dart';

class CachedCategoryRepository {
  final ApiService _apiService;
  final CacheService _cacheService;

  CachedCategoryRepository(this._apiService, this._cacheService);

  Future<ApiResult<CategoryResponse>> fetchCategories() async {
    try {
      // First, try to get data from cache
      final cachedData = await _cacheService.getCachedCategories();

      if (cachedData != null) {
        // Return cached data immediately
        return ApiResult.success(cachedData);
      }

      // If no cache, fetch from API
      final apiResult = await _apiService.fetchAllCategory();
      
      // Cache the result if successful
      apiResult.when(
        success: (data) async {
          await _cacheService.cacheCategories(data);
        },
        failure: (error) {
          // Don't cache errors
        },
      );

      return apiResult;
    } catch (e) {
      return ApiResult.failure(ApiException(
        message: 'Failed to fetch categories: $e',
        code: 500,
      ));
    }
  }

  // Force refresh from API (bypass cache)
  Future<ApiResult<CategoryResponse>> refreshCategories() async {
    try {
      final apiResult = await _apiService.fetchAllCategory();
      
      // Cache the result if successful
      apiResult.when(
        success: (data) async {
          await _cacheService.cacheCategories(data);
        },
        failure: (error) {
          // Don't cache errors
        },
      );

      return apiResult;
    } catch (e) {
      return ApiResult.failure(ApiException(
        message: 'Failed to refresh categories: $e',
        code: 500,
      ));
    }
  }

  // Clear cache for categories
  Future<void> clearCategoriesCache() async {
    await _cacheService.clearAllCache();
  }
} 