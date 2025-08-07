import 'package:pharmacy/core/network/api_service.dart';
import 'package:pharmacy/core/network/api_result.dart';
import 'package:pharmacy/core/network/api_exception.dart';
import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/core/db/cache/cache_service.dart';

class CachedItemListRepository {
  final ApiService _apiService;
  final CacheService _cacheService;

  CachedItemListRepository(this._apiService, this._cacheService);

  Future<ApiResult<ProductResponse>> fetchAllProduct({required int page}) async {
    try {
      // First, try to get data from cache
      final cachedData = await _cacheService.getCachedProducts(
        page,
        fetchType: 'all',
      );

      if (cachedData != null) {
        // Return cached data immediately
        return ApiResult.success(cachedData);
      }

      // If no cache, fetch from API
      final apiResult = await _apiService.fetchAllProduct(page);
      
      // Cache the result if successful
      apiResult.when(
        success: (data) async {
          await _cacheService.cacheProducts(
            data,
            page,
            fetchType: 'all',
          );
        },
        failure: (error) {
          // Don't cache errors
        },
      );

      return apiResult;
    } catch (e) {
      return ApiResult.failure(ApiException(
        message: 'Failed to fetch all products: $e',
        code: 500,
      ));
    }
  }

  Future<ApiResult<ProductResponse>> fetchProductByCategory({
    required int categoryId,
    required int page,
  }) async {
    try {
      // First, try to get data from cache
      final cachedData = await _cacheService.getCachedProducts(
        page,
        categoryId: categoryId,
        fetchType: 'category',
      );

      if (cachedData != null) {
        // Return cached data immediately
        return ApiResult.success(cachedData);
      }

      // If no cache, fetch from API
      final apiResult = await _apiService.fetchProductByCategory(
        categoryId: categoryId,
        page: page,
      );
      
      // Cache the result if successful
      apiResult.when(
        success: (data) async {
          await _cacheService.cacheProducts(
            data,
            page,
            categoryId: categoryId,
            fetchType: 'category',
          );
        },
        failure: (error) {
          // Don't cache errors
        },
      );

      return apiResult;
    } catch (e) {
      return ApiResult.failure(ApiException(
        message: 'Failed to fetch products by category: $e',
        code: 500,
      ));
    }
  }

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
      return ApiResult.failure(ApiException(
        message: 'Failed to fetch best sellers: $e',
        code: 500,
      ));
    }
  }

  Future<ApiResult<ProductResponse>> fetchSeeOurProducts({required int page}) async {
    try {
      // First, try to get data from cache
      final cachedData = await _cacheService.getCachedProducts(
        page,
        fetchType: 'seeOurProducts',
      );

      if (cachedData != null) {
        // Return cached data immediately
        return ApiResult.success(cachedData);
      }

      // If no cache, fetch from API
      final apiResult = await _apiService.fetchSeeOurProducts(page);
      
      // Cache the result if successful
      apiResult.when(
        success: (data) async {
          await _cacheService.cacheProducts(
            data,
            page,
            fetchType: 'seeOurProducts',
          );
        },
        failure: (error) {
          // Don't cache errors
        },
      );

      return apiResult;
    } catch (e) {
      return ApiResult.failure(ApiException(
        message: 'Failed to fetch see our products: $e',
        code: 500,
      ));
    }
  }

  // Force refresh from API (bypass cache)
  Future<ApiResult<ProductResponse>> refreshAllProducts({required int page}) async {
    try {
      final apiResult = await _apiService.fetchAllProduct(page);
      
      // Cache the result if successful
      apiResult.when(
        success: (data) async {
          await _cacheService.cacheProducts(
            data,
            page,
            fetchType: 'all',
          );
        },
        failure: (error) {
          // Don't cache errors
        },
      );

      return apiResult;
    } catch (e) {
      return ApiResult.failure(ApiException(
        message: 'Failed to refresh all products: $e',
        code: 500,
      ));
    }
  }

  // Clear cache for all products
  Future<void> clearAllProductsCache() async {
    await _cacheService.clearAllCache();
  }
} 