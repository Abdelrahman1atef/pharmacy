import 'package:pharmacy/app_config_provider/cashe_helper.dart';
import 'package:pharmacy/core/network/api_result.dart';
import 'package:pharmacy/core/network/api_service.dart';
import 'package:pharmacy/features/admin/dashboard/data/models/dashboard_response.dart';

class DashboardRepository {
  final ApiService apiService;
  DashboardRepository(this.apiService);

  Future<ApiResult<DashboardResponse>> fetchDashboardData() async {
    final token = CashHelper.getToken();
    if (token == null) {
      throw Exception('Authentication required');
    }
    return apiService.fetchAdminDashboard(token: token);
  }
} 