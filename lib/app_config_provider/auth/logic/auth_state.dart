import 'package:freezed_annotation/freezed_annotation.dart';
import '../model/data.dart';
part 'auth_state.freezed.dart';
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.authenticated(Data user) = AuthAuthenticated;
  const factory AuthState.unauthenticated({String? message}) = AuthUnauthenticated;
  const factory AuthState.loading() = AuthLoading;
}
