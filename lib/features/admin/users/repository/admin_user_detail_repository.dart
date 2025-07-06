import 'package:pharmacy/core/models/admin_user/admin_user_detail_response.dart';
import 'package:pharmacy/core/network/api_service.dart';
import 'package:pharmacy/app_config_provider/cashe_helper.dart';

abstract class AdminUserDetailRepository {
  Future<AdminUserDetailResponse> fetchUserDetail({
    required int userId,
  });
}

class AdminUserDetailRepositoryImpl implements AdminUserDetailRepository {
  final ApiService _apiService;

  AdminUserDetailRepositoryImpl(this._apiService);

  @override
  Future<AdminUserDetailResponse> fetchUserDetail({
    required int userId,
  }) async {
    final token = CashHelper.getToken();
    if (token == null) {
      throw Exception('Authentication required');
    }
    final result = await _apiService.fetchAdminUserDetail(
      userId,
      token: token,
    );

    return result.when(
      success: (data) => data,
      failure: (exception) => throw Exception(exception.message),
    );
  }
} 