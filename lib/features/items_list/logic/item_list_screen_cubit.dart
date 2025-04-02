import 'package:bloc/bloc.dart';
import '../../../core/models/product_response.dart';
import '../repository/item_list/item_list.dart';
import 'item_list_screen_state.dart';

class ItemListScreenCubit extends Cubit<ItemListScreenState> {
  final ItemListRepository _itemListRepository;
  int _currentPage = 1;
  bool _hasReachedMax = false;

  ItemListScreenCubit(this._itemListRepository) : super(const Initial());

  Future<void> fetchInitialItems() async {

    emit(const Loading());


    _itemListRepository.fetchAllProduct(page: 1).then((result) {
      result.when(
        success: (ProductResponse data) {
          _currentPage = 1;
          _hasReachedMax = data.next == null;
          emit(Success(data));
        },
        failure: (e) => emit(Error(e)),
      );
    });
  }

  Future<void> fetchMoreItems() async {
    if (_hasReachedMax) return;

    final currentData = state.maybeWhen(
      success: (data) => data,
      loadingMore: (data) => data,
      orElse: () => null,
    );

    if (currentData == null) return;

    emit(ItemListScreenState.loadingMore(currentData));
      _itemListRepository.fetchAllProduct(page: _currentPage+1).then((result){
        result.when(success: (newData) {
          _currentPage++;
          _hasReachedMax = newData.next == null;

          final updatedResults = ProductResponse(
              count: newData.count,
              next: newData.next,
              previous: newData.previous,
              results: [...currentData.results, ...newData.results],);

          emit(Success(updatedResults));
        }, failure: (e) => emit(Error(e)),);
      });
      
     
  }
}
