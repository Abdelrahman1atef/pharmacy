import 'package:pharmacy/core/network/api_service.dart';

import '../../../core/models/register_login/register_request.dart';
import '../../../core/network/api_result.dart';

class SignupRepository {
  final ApiService _apiService;

  SignupRepository(this._apiService);

  Future<ApiResult<RegisterRequest>>userRegister(RegisterRequest register)async{
    return await  _apiService.userRegister(register);
  }
}