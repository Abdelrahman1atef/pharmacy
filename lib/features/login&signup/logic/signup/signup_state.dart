import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy/core/network/api_exception.dart';

import '../../../../core/models/register_login/register_response.dart';
part 'signup_state.freezed.dart';

@freezed
class SignupState with _$SignupState {
  const factory SignupState.initial() = Initial;
  const factory SignupState.loading() = Loading;
  const factory SignupState.success(RegisterResponse data) = Success;
  const factory SignupState.error(ApiException e) = Error;
}

