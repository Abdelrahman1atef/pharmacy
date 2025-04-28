
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/features/search/logic/search_state.dart';

import '../../../core/models/search/search_response.dart';
import '../repository/search_repository.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _searchRepository;
  SearchCubit(this._searchRepository) : super((const Initial()));

  void emitSearchState(String query) {
    emit(const Loading());
    _searchRepository.getSearch(query).then((result) {
      result.when(
          success: (List<SearchResponse> data) => emit(Success(data)),
          failure: (error) => emit(Error(error)));
    });
  }
}
