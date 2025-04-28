import 'package:bloc/bloc.dart';

import 'login_state.dart';


class LoginScreenCubit extends Cubit<LoginScreenState> {
  LoginScreenCubit()
      : super(LoginScreenState(
          isPhoneSelected: true,
          isPasswordVisible: false,
        ));
  void setPhoneSelected(bool isPhoneSelected) {
    emit(state.copyWith(
      isPhoneSelected: isPhoneSelected
    ));
  }

  void setPasswordVisible(bool isPasswordVisible) {
    emit(state.copyWith(
      isPasswordVisible: isPasswordVisible
    ));
  }
}
