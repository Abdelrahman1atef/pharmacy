import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/app_config_provider/cashe_helper.dart';
import 'package:pharmacy/core/models/register_login/login_request.dart';
import '../repository/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const AuthInitial());

  Future<void> checkAuthStatus() async {

      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        user.when(
            success: (data) => emit(AuthAuthenticated(data)),
            failure: (e) => emit( AuthUnauthenticated(message: e.message)));
      } else {
        emit(const AuthUnauthenticated());
      }
  }

  Future<void> login(LoginRequest loginBody) async {
    emit(const AuthLoading());

      final result = await _authRepository.login(loginBody);
      result.when(
        success: (loginResponse) {
          CashHelper.saveToken(loginResponse.token);
          if (!isClosed) emit(AuthAuthenticated(loginResponse.user));
        },
        failure: (e) {
          if (!isClosed) {
            emit(AuthUnauthenticated(message: e.message));
          }
        },
      );
  }

  Future<void> logout() async {
    await _authRepository.logout();
    emit(const AuthUnauthenticated());
  }
}
