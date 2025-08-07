import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/core/network/api_result.dart';
import 'cache_manager.dart';

abstract class CachedCubitBase<T> extends Cubit<T> {
  final CacheManager _cacheManager = CacheManager();

  CachedCubitBase(T initialState) : super(initialState);

  /// Load data with cache-first approach
  Future<void> loadCachedData<TData>({
    required String cacheKey,
    required Future<ApiResult<TData>> Function() apiCall,
    required Function(TData) onSuccess,
    required Function(dynamic) onError,
  }) async {
    try {
      // Check if we have valid cache
      final hasCache = await _cacheManager.hasValidCache(cacheKey);
      
      if (hasCache) {
        // Try to load from cache first for instant response
        // The repository will handle the cache logic
        final result = await apiCall();
        result.when(
          success: onSuccess,
          failure: (error) {
            // If cache fails, try API
            _loadFromApi(apiCall, onSuccess, onError);
          },
        );
      } else {
        // No cache, load from API
        await _loadFromApi(apiCall, onSuccess, onError);
      }
    } catch (e) {
      onError(e);
    }
  }

  Future<void> _loadFromApi<TData>(
    Future<ApiResult<TData>> Function() apiCall,
    Function(TData) onSuccess,
    Function(dynamic) onError,
  ) async {
    try {
      final result = await apiCall();
      result.when(
        success: onSuccess,
        failure: onError,
      );
    } catch (e) {
      onError(e);
    }
  }

  /// Clear specific cache
  Future<void> clearCache(String cacheKey) async {
    await _cacheManager.clearCache(cacheKey);
  }

  /// Clear all cache
  Future<void> clearAllCache() async {
    await _cacheManager.clearAllCache();
  }

  /// Get cache statistics
  Future<Map<String, dynamic>> getCacheStats() async {
    return await _cacheManager.getCacheStats();
  }
} 