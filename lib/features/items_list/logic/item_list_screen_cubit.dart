import 'package:bloc/bloc.dart';
import '../../../core/models/product/product_response.dart';
import '../../../core/network/api_result.dart';
import '../repository/item_list/item_list_repository.dart';
import 'item_list_screen_state.dart';

enum FetchType { all, category, bestSellers, seeOurProducts }

class ItemListScreenCubit extends Cubit<ItemListScreenState> {
  final ItemListRepository _itemListRepository;
  int _currentPage = 1;
  bool _hasReachedMax = false;
  bool _isLoadingMore = false;
  int? _selectedCategoryId;
  FetchType _fetchType = FetchType.all;

  ItemListScreenCubit(this._itemListRepository) : super(const Initial());

  Future<void> fetchInitialItems({int? categoryId, FetchType? fetchType}) async {
    emit(const Loading());
    _currentPage = 1;
    _hasReachedMax = false;
    _selectedCategoryId = categoryId;
    _fetchType = fetchType ?? (categoryId != null ? FetchType.category : FetchType.all);

    final result = await _getApiResult(_currentPage);

    result.when(
      success: (data) {
        _hasReachedMax = data.next == null;
        emit(Success(data));
      },
      failure: (e) => emit(Error(e)),
    );
  }

  Future<void> fetchMoreItems() async {
    if (_hasReachedMax|| _isLoadingMore) return;
    _isLoadingMore = true;
    final currentData = state.maybeWhen(
      success: (data) => data,
      loadingMore: (data) => data,
      orElse: () => null,
    );

    if (currentData == null) {
      _isLoadingMore = false;
      return;
    }

    emit(ItemListScreenState.loadingMore(currentData));

    final result = await _getApiResult(_currentPage + 1);

      result.when(
        success: (newData) {
          _currentPage++;
          _hasReachedMax = newData.next == null;

          final updatedResults = ProductResponse(
            count: newData.count,
            next: newData.next,
            previous: newData.previous,
            results: [...currentData.results, ...newData.results],
          );

          emit(Success(updatedResults));
        },
        failure: (e) => emit(Error(e)),
      );
    _isLoadingMore = false;
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
}
