import 'package:pharmacy/core/db/cache/cache_service.dart';
import 'package:pharmacy/core/db/dbHelper/db_constants.dart';

class CacheManager {
  static final CacheManager _instance = CacheManager._internal();
  factory CacheManager() => _instance;
  CacheManager._internal();

  final CacheService _cacheService = CacheService();

  /// Initialize cache manager
  Future<void> initialize() async {
    // Clear expired cache entries on app start
    await _cacheService.clearExpiredCache();
  }

  /// Clear all cache
  Future<void> clearAllCache() async {
    await _cacheService.clearAllCache();
  }

  /// Clear specific cache types
  Future<void> clearProductCache() async {
    await _cacheService.clearCache(allProductsCacheKey);
    await _cacheService.clearCache(bestSellersCacheKey);
    await _cacheService.clearCache(seeOurProductsCacheKey);
  }

  Future<void> clearCategoryCache() async {
    await _cacheService.clearCache(categoriesCacheKey);
  }

  Future<void> clearCategoryProductsCache(int categoryId) async {
    await _cacheService.clearCache('${productsByCategoryCacheKey}$categoryId');
  }

  /// Get cache statistics
  Future<Map<String, dynamic>> getCacheStats() async {
    return await _cacheService.getCacheInfo();
  }

  /// Check if cache is available for specific data
  Future<bool> hasValidCache(String cacheKey) async {
    return await _cacheService.hasValidCache(cacheKey);
  }

  /// Preload essential cache data
  Future<void> preloadEssentialData() async {
    // This can be used to preload critical data on app start
    // For now, we'll just clear expired cache
    await _cacheService.clearExpiredCache();
  }
} 