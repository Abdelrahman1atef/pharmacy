import 'package:pharmacy/core/models/order/admin/admin_order_model.dart';
import 'package:pharmacy/core/network/api_result.dart';
import 'package:pharmacy/core/network/api_service.dart';
import 'package:pharmacy/core/network/api_exception.dart';

import '../../../../app_config_provider/cashe_helper.dart';
import '../../../../core/enum/order_status.dart';


class AdminOrdersRepository {
  final ApiService _apiService;

  AdminOrdersRepository(this._apiService);
  
  Future<ApiResult<AdminOrderResponse>> getAdminOrders()async{
    final token = CashHelper.getToken();
    print('AdminOrdersRepository - Token: $token');
    
    if (token == null || token.isEmpty) {
      print('AdminOrdersRepository - No token found!');
      return Future.value(ApiResult<AdminOrderResponse>.failure(ApiException(
        message: 'Authentication token not found',
        code: 401,
      )));
    }
    
    return _apiService.getAdminOrders(token);
  }
  
  Future<void> updateOrderStatus(int orderId, OrderStatus newStatus)async{
    final token = CashHelper.getToken();

    if (token == null || token.isEmpty) {
      print('AdminOrdersRepository - No token found for update!');
      throw ApiException(
        message: 'Authentication token not found',
        code: 401,
      );
    }
    
    return _apiService.updateOrderStatus(orderId,newStatus,token);
  }
}