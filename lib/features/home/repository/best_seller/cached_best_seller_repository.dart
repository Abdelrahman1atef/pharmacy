import 'package:pharmacy/core/network/api_service.dart';
import 'package:pharmacy/core/network/api_result.dart';
import 'package:pharmacy/core/network/api_exception.dart';
import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/core/db/cache/cache_service.dart';

class CachedBestSellerRepository {
  final ApiService _apiService;
  final CacheService _cacheService;

  CachedBestSellerRepository(this._apiService, this._cacheService);

  Future<ApiResult<ProductResponse>> fetchBestSellers({required int page}) async {
    try {
      // First, try to get data from cache
      final cachedData = await _cacheService.getCachedProducts(
        page,
        fetchType: 'bestSellers',
      );

      if (cachedData != null) {
        // Return cached data immediately
        return ApiResult.success(cachedData);
      }

      // If no cache, fetch from API
      final apiResult = await _apiService.fetchBestSellers(page);
      
      // Cache the result if successful
      apiResult.when(
        success: (data) async {
          await _cacheService.cacheProducts(
            data,
            page,
            fetchType: 'bestSellers',
          );
        },
        failure: (error) {
          // Don't cache errors
        },
      );

      return apiResult;
    } catch (e) {
      return ApiResult.failure(Exception('Failed to fetch best sellers: $e'));
    }
  }

  // Force refresh from API (bypass cache)
  Future<ApiResult<ProductResponse>> refreshBestSellers({required int page}) async {
    try {
      final apiResult = await _apiService.fetchBestSellers(page);
      
      // Cache the result if successful
      apiResult.when(
        success: (data) async {
          await _cacheService.cacheProducts(
            data,
            page,
            fetchType: 'bestSellers',
          );
        },
        failure: (error) {
          // Don't cache errors
        },
      );

      return apiResult;
    } catch (e) {
      return ApiResult.failure(Exception('Failed to refresh best sellers: $e'));
    }
  }

  // Clear cache for best sellers
  Future<void> clearBestSellersCache() async {
    // This would require a more specific cache clearing method
    // For now, we'll clear all cache
    await _cacheService.clearAllCache();
  }
} 