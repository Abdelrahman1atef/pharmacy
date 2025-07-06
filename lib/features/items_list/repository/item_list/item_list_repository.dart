import 'package:pharmacy/core/network/api_service.dart';

import '../../../../core/models/product/product_response.dart';
import '../../../../core/network/api_result.dart';

class ItemListRepository {
  final ApiService _apiService;

  ItemListRepository(this._apiService);

  Future<ApiResult<ProductResponse>> fetchAllProduct({required int page}) async{
    return _apiService.fetchAllProduct(page);
  }
  
  Future<ApiResult<ProductResponse>> fetchBestSellers({required int page}) async{
    return _apiService.fetchBestSellers(page);
  }
  
  Future<ApiResult<ProductResponse>> fetchSeeOurProducts({required int page}) async{
    return _apiService.fetchSeeOurProducts(page);
  }
  
  Future<ApiResult<ProductResponse>> fetchProductByCategory({required int page,required int categoryId,}) async{
    return _apiService.fetchProductByCategory(categoryId: categoryId, page: page);
  }
}