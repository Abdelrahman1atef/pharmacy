import 'package:pharmacy/core/network/api_result.dart';
import 'package:pharmacy/core/network/api_service.dart';

import '../../../core/models/search_response.dart';

class SearchRepository {
  final ApiService _apiService;

  SearchRepository(this._apiService);

  Future<ApiResult<List<SearchResponse>>> getSearch(String query) async {
    return await _apiService.searchProduct(query);
  }
}
