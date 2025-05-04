

import 'package:pharmacy/app_config_provider/cashe_helper.dart';

import '../../../core/models/register_login/login_request.dart';
import '../../../core/models/register_login/login_response.dart';
import '../../../core/network/api_result.dart';
import '../../../core/network/api_service.dart';
import '../model/data.dart';

class AuthRepository {
  final ApiService _apiService;
  AuthRepository(this._apiService);

  Future<ApiResult<Data>?> getCurrentUser() async {
    final token = CashHelper.getToken(); // From shared preferences
    if (token != null) {
      return await _apiService.getProfile(token);
    }
    return null;
  }

  Future<ApiResult<LoginResponse>> login(LoginRequest loginBody) {
   return _apiService.userLogin(loginBody);
  }

  Future<void> logout() async {
    await CashHelper.clearToken();
  }
}
