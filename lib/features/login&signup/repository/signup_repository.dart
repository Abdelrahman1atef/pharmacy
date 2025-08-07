import 'package:pharmacy/core/network/api_service.dart';

import '../../../core/models/register_login/register_request.dart';
import '../../../core/models/register_login/register_response.dart';
import '../../../core/network/api_result.dart';

class SignupRepository {
  final ApiService apiService;
  SignupRepository(this.apiService);

  Future<ApiResult<RegisterResponse>>userRegister(RegisterRequest register)async{
    return await  apiService.userRegister(register);
  }

  Future<void> verifyOtp(String email, String otp) async {
    await apiService.verifyOtp(email, otp);
  }

  Future<void> resendOtp(String email) async {
    await apiService.resendOtp(email);
  }
}