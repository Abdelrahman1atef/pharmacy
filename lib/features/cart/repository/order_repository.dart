import 'package:pharmacy/core/network/api_service.dart';

import '../../../app_config_provider/cashe_helper.dart';
import '../../../core/models/order/create/order_request.dart';
import '../../../core/models/order/create/order_response.dart';
import '../../../core/network/api_result.dart';

class OrderRepository {
  final ApiService _apiService;
  OrderRepository(this._apiService);
  final token = CashHelper.getToken();
  Future<ApiResult<OrderResponse>> createOrder(OrderRequest orderBody){
    return _apiService.createOrder(orderBody,token);
  }
}