import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy/features/login&signup/logic/signup/signup_state.dart';
import 'package:pharmacy/features/login&signup/repository/signup_repository.dart';

import '../../../../core/models/register_login/register_request.dart';
import '../../../../core/network/api_result.dart';


class SignupCubit extends Cubit<SignupState> {
  final SignupRepository _signupRepository;

  SignupCubit(this._signupRepository) : super(const Initial());

  Future<void> emitUserRegister(RegisterRequest register) async {
    emit(const Loading());
    _signupRepository.userRegister(register).then((result) {
      result.when(success: (data) => emit(Success(data)), failure: (e) => Error(e),);
    });
  }
}
