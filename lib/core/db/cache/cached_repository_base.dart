import 'dart:convert';
import 'package:pharmacy/core/network/api_result.dart';
import 'package:pharmacy/core/network/api_exception.dart';
import 'cache_service.dart';

abstract class CachedRepositoryBase {
  final CacheService _cacheService = CacheService();

  /// Get data with caching - tries cache first, then API
  Future<ApiResult<T>> getCachedData<T>({
    required String cacheKey,
    required Future<ApiResult<T>> Function() apiCall,
    required int expiryMs,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      // Try to get from cache first
      final cachedData = await _cacheService.getFromCache(cacheKey);
      if (cachedData != null) {
        return ApiResult.success(fromJson(cachedData));
      }

      // If not in cache, fetch from API
      final apiResult = await apiCall();
      
      // If API call successful, save to cache
      apiResult.when(
        success: (data) async {
          // Convert the response object to JSON using its toJson() method
          Map<String, dynamic> jsonData;
          try {
            // Try to use toJson() method if available
            final dynamic dynamicData = data;
            if (dynamicData != null && dynamicData.toJson != null) {
              jsonData = dynamicData.toJson();
            } else {
              // Fallback: try to encode and decode to get a Map
              jsonData = jsonDecode(jsonEncode(data));
            }
          } catch (e) {
            // If toJson() fails, use fallback method
            jsonData = jsonDecode(jsonEncode(data));
          }
          await _cacheService.saveToCache(cacheKey, jsonData, expiryMs);
        },
        failure: (error) {
          // Don't cache errors
        },
      );

      return apiResult;
    } catch (e) {
      return ApiResult.failure(ApiException(message: 'Cache operation failed: $e', code: 500));
    }
  }

  /// Get data with pagination caching
  Future<ApiResult<T>> getCachedPaginatedData<T>({
    required String cacheKey,
    required int page,
    required Future<ApiResult<T>> Function(int page) apiCall,
    required int expiryMs,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final pageCacheKey = '${cacheKey}_page_$page';
    return getCachedData(
      cacheKey: pageCacheKey,
      apiCall: () => apiCall(page),
      expiryMs: expiryMs,
      fromJson: fromJson,
    );
  }

  /// Clear specific cache
  Future<void> clearCache(String cacheKey) async {
    await _cacheService.clearCache(cacheKey);
  }

  /// Clear all cache
  Future<void> clearAllCache() async {
    await _cacheService.clearAllCache();
  }

  /// Check if cache exists
  Future<bool> hasValidCache(String cacheKey) async {
    return await _cacheService.hasValidCache(cacheKey);
  }
} 