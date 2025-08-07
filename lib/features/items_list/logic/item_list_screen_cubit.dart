import 'package:pharmacy/core/db/cache/cached_cubit_base.dart';
import 'package:pharmacy/core/db/dbHelper/db_constants.dart';
import '../../../core/models/product/product_response.dart';
import '../../../core/network/api_result.dart';
import '../repository/item_list/item_list_repository.dart';
import 'item_list_screen_state.dart';
import 'dart:async';

enum FetchType { all, category, bestSellers, seeOurProducts }

class ItemListScreenCubit extends CachedCubitBase<ItemListScreenState> {
  final ItemListRepository _itemListRepository;
  int _currentPage = 1;
  bool _hasReachedMax = false;
  bool _isLoadingMore = false;
  int? _selectedCategoryId;
  FetchType _fetchType = FetchType.all;
  
  // Add debouncing timer
  Timer? _debounceTimer;
  bool _isFetching = false;

  ItemListScreenCubit(this._itemListRepository) : super(const Initial());

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }

  Future<void> fetchInitialItems({int? categoryId, FetchType? fetchType}) async {
    // Cancel any pending debounced calls
    _debounceTimer?.cancel();
    
    emit(const Loading());
    _currentPage = 1;
    _hasReachedMax = false;
    _isLoadingMore = false;
    _isFetching = false;
    _selectedCategoryId = categoryId;
    _fetchType = fetchType ?? (categoryId != null ? FetchType.category : FetchType.all);

    final cacheKey = _getCacheKey(_currentPage);
    
    await loadCachedData<ProductResponse>(
      cacheKey: cacheKey,
      apiCall: () => _getApiResult(_currentPage),
      onSuccess: (data) {
        _hasReachedMax = data.next == null;
        emit(Success(data));
      },
      onError: (e) => emit(Error(e)),
    );
  }

  Future<void> fetchMoreItems() async {
    // Prevent multiple simultaneous calls
    if (_hasReachedMax || _isLoadingMore || _isFetching) return;
    
    // Debounce rapid scroll events
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      await _performFetchMore();
    });
  }

  Future<void> _performFetchMore() async {
    if (_hasReachedMax || _isLoadingMore || _isFetching) return;
    
    _isLoadingMore = true;
    _isFetching = true;
    
    final currentData = state.maybeWhen(
      success: (data) => data,
      loadingMore: (data) => data,
      orElse: () => null,
    );

    if (currentData == null) {
      _isLoadingMore = false;
      _isFetching = false;
      return;
    }

    emit(ItemListScreenState.loadingMore(currentData));

    final nextPage = _currentPage + 1;
    final cacheKey = _getCacheKey(nextPage);
    
    try {
      await loadCachedData<ProductResponse>(
        cacheKey: cacheKey,
        apiCall: () => _getApiResult(nextPage),
        onSuccess: (newData) {
          _currentPage = nextPage;
          _hasReachedMax = newData.next == null;

          final updatedResults = ProductResponse(
            count: newData.count,
            next: newData.next,
            previous: newData.previous,
            results: [...currentData.results, ...newData.results],
          );

          emit(Success(updatedResults));
        },
        onError: (e) {
          // Revert to previous state on error
          emit(Success(currentData));
        },
      );
    } finally {
      _isLoadingMore = false;
      _isFetching = false;
    }
  }

  Future<ApiResult<ProductResponse>> _getApiResult(int page) async {
    switch (_fetchType) {
      case FetchType.all:
        return await _itemListRepository.fetchAllProduct(page: page);
      case FetchType.category:
        return await _itemListRepository.fetchProductByCategory(
          page: page, 
          categoryId: _selectedCategoryId!
        );
      case FetchType.bestSellers:
        return await _itemListRepository.fetchBestSellers(page: page);
      case FetchType.seeOurProducts:
        return await _itemListRepository.fetchSeeOurProducts(page: page);
    }
  }

  String _getCacheKey(int page) {
    switch (_fetchType) {
      case FetchType.all:
        return '${allProductsCacheKey}_page_$page';
      case FetchType.category:
        return '$productsByCategoryCacheKey${_selectedCategoryId}_page_$page';
      case FetchType.bestSellers:
        return '${bestSellersCacheKey}_page_$page';
      case FetchType.seeOurProducts:
        return '${seeOurProductsCacheKey}_page_$page';
    }
  }

  /// Clear cache for current fetch type and refresh
  Future<void> refreshItems() async {
    // Cancel any pending debounced calls
    _debounceTimer?.cancel();
    
    final cacheKey = _getCacheKey(_currentPage);
    await clearCache(cacheKey);
    await fetchInitialItems(
      categoryId: _selectedCategoryId,
      fetchType: _fetchType,
    );
  }

  /// Clear all cache for current category/fetch type
  Future<void> clearAllCacheForCurrentType() async {
    // Clear all pages for current fetch type
    for (int page = 1; page <= _currentPage; page++) {
      final cacheKey = _getCacheKey(page);
      await clearCache(cacheKey);
    }
  }
}
