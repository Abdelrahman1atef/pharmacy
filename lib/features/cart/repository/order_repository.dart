import 'package:pharmacy/core/network/api_service.dart';
import 'package:pharmacy/core/network/api_exception.dart';

import '../../../app_config_provider/cashe_helper.dart';
import '../../../core/models/order/create/order_request.dart';
import '../../../core/models/order/create/order_response.dart';
import '../../../core/network/api_result.dart';

class OrderRepository {
  final ApiService _apiService;
  OrderRepository(this._apiService);
  
  Future<ApiResult<OrderResponse>> createOrder(OrderRequest orderBody){
    final token = CashHelper.getToken();
    print('OrderRepository - Token: $token');
    
    if (token == null || token.isEmpty) {
      print('OrderRepository - No token found!');
      return Future.value(ApiResult<OrderResponse>.failure(ApiException(
        message: 'Authentication token not found',
        code: 401,
      )));
    }
    
    return _apiService.createOrder(orderBody,token);
  }
}