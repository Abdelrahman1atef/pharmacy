import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy/core/network/api_exception.dart';
part 'signup_state.freezed.dart';

@freezed
class SignupState<T> with _$SignupState {
  const factory SignupState.initial() = Initial;
  const factory SignupState.loading() = Loading;
  const factory SignupState.success(T data) = Success<T>;
  const factory SignupState.error(ApiException e) = Error;
}

