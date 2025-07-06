import 'package:pharmacy/core/network/api_service.dart';

import '../../../../core/models/product/product_response.dart';
import '../../../../core/network/api_result.dart';

class BestSellerRepository {
  final ApiService _apiService;

  BestSellerRepository(this._apiService);
  Future<ApiResult<ProductResponse>> fetchBestSellers({required int page}) async{
    return _apiService.fetchBestSellers(page);
  }
}