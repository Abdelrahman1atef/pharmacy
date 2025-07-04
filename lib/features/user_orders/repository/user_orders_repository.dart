import 'package:pharmacy/core/models/order/admin/admin_order_model.dart';
import 'package:pharmacy/core/network/api_result.dart';
import 'package:pharmacy/core/network/api_service.dart';

import '../../../../app_config_provider/cashe_helper.dart';
import '../../../../core/enum/order_status.dart';
import '../../../core/models/order/customer/customer_order_model.dart';


class UserOrdersRepository {
  final ApiService _apiService;

  UserOrdersRepository(this._apiService);
  final token = CashHelper.getToken();
  Future<ApiResult<List<CustomerOrderModel>>> getCustomerOrders()async{
    return _apiService.getCustomerOrders(token);
  }
}