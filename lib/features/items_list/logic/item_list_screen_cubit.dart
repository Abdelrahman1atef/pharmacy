import 'package:bloc/bloc.dart';
import '../../../core/models/product/product_response.dart';
import '../repository/item_list/item_list_repository.dart';
import 'item_list_screen_state.dart';

enum FetchType { all, category }

class ItemListScreenCubit extends Cubit<ItemListScreenState> {
  final ItemListRepository _itemListRepository;
  int _currentPage = 1;
  bool _hasReachedMax = false;
  bool _isLoadingMore = false;
  int? _selectedCategoryId;
  FetchType _fetchType = FetchType.all;

  ItemListScreenCubit(this._itemListRepository) : super(const Initial());

  Future<void> fetchInitialItems({int? categoryId}) async {
    emit(const Loading());
    _currentPage = 1;
    _hasReachedMax = false;
    _selectedCategoryId = categoryId;
    _fetchType = categoryId == null ? FetchType.all : FetchType.category;

    final result = categoryId == null
        ? await _itemListRepository.fetchAllProduct(page: _currentPage)
        : await _itemListRepository.fetchProductByCategory(
        page: _currentPage, categoryId: categoryId);

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

    final result = _fetchType == FetchType.all
        ? await _itemListRepository.fetchAllProduct(page: _currentPage + 1)
        : await _itemListRepository.fetchProductByCategory(
      page: _currentPage + 1,
      categoryId: _selectedCategoryId!,
    );

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
}
