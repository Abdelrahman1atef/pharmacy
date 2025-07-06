import 'package:pharmacy/core/network/api_service.dart';

import '../../../../core/models/product/product_response.dart';
import '../../../../core/network/api_result.dart';

class SeeOurProductsRepository {
  final ApiService _apiService;

  SeeOurProductsRepository(this._apiService);
  Future<ApiResult<ProductResponse>> fetchSeeOurProducts({required int page}) async{
    return _apiService.fetchSeeOurProducts(page);
  }
} 