import 'package:pharmacy/core/network/api_service.dart';

import '../../../../core/models/product_response.dart';
import '../../../../core/network/api_result.dart';

class BestSellerRepository {
  final ApiService _apiService;

  BestSellerRepository(this._apiService);
  Future<ApiResult<ProductResponse>> fetchAllProduct() async{
    return _apiService.fetchAllProduct();
  }
}