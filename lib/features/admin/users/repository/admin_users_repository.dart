import 'package:pharmacy/core/models/admin_user/admin_user_list_response.dart';
import 'package:pharmacy/core/network/api_service.dart';
import 'package:pharmacy/app_config_provider/cashe_helper.dart';

abstract class AdminUsersRepository {
  Future<AdminUserListResponse> fetchUsers({
    String? search,
    required int page,
  });
}

class AdminUsersRepositoryImpl implements AdminUsersRepository {
  final ApiService _apiService;

  AdminUsersRepositoryImpl(this._apiService);

  @override
  Future<AdminUserListResponse> fetchUsers({
    String? search,
    required int page,
  }) async {
    final token = CashHelper.getToken();
    if (token == null) {
      throw Exception('Authentication required');
    }

    final result = await _apiService.fetchAdminUsers(
      search: search,
      page: page,
      token: token,
    );

    return result.when(
      success: (data) => data,
      failure: (exception) => throw Exception(exception.message),
    );
  }
} 