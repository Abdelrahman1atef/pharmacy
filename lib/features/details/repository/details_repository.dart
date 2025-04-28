import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/core/network/api_result.dart';
import 'package:pharmacy/core/network/api_service.dart';

class DetailsRepository {
  final ApiService _apiService;

  DetailsRepository(this._apiService);

  Future<ApiResult<Results>> getProductDetails(int productId) async {
    return await _apiService.fetchProductDetails(productId);
  }
}
