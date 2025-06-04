import 'package:pharmacy/core/models/order/admin/admin_order_model.dart';
import 'package:pharmacy/core/network/api_result.dart';
import 'package:pharmacy/core/network/api_service.dart';

import '../../../../app_config_provider/cashe_helper.dart';


class AdminOrdersRepository {
  final ApiService _apiService;

  AdminOrdersRepository(this._apiService);
  final token = CashHelper.getToken();
  Future<ApiResult<List<AdminOrderModel>>> getAdminOrders()async{
    return _apiService.getAdminOrders(token);
  }
}