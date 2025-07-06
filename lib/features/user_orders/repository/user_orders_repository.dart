import 'package:pharmacy/core/network/api_result.dart';
import 'package:pharmacy/core/network/api_service.dart';
import 'package:pharmacy/core/network/api_exception.dart';

import '../../../../app_config_provider/cashe_helper.dart';
import '../../../core/models/order/customer/customer_order_model.dart';


class UserOrdersRepository {
  final ApiService _apiService;

  UserOrdersRepository(this._apiService);
  
  Future<ApiResult<List<CustomerOrderModel>>> getCustomerOrders()async{
    final token = CashHelper.getToken();
    print('UserOrdersRepository - Token: $token');
    
    if (token == null || token.isEmpty) {
      print('UserOrdersRepository - No token found!');
      return ApiResult.failure(ApiException(
        message: 'Authentication token not found',
        code: 401,
      ));
    }
    
    return _apiService.getCustomerOrders(token);
  }
}