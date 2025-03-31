import 'package:pharmacy/core/network/api_service.dart';

import '../../../../core/models/category_response.dart';
import '../../../../core/network/api_result.dart';

class CategoryRepository {
  final ApiService _apiService;

  CategoryRepository(this._apiService);
  Future<ApiResult<List<CategoryResponse>>> fetchAllCategory() async{
    return _apiService.fetchAllCategory();
  }
}