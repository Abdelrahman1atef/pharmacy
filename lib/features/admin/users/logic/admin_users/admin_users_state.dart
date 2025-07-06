part of 'admin_users_cubit.dart';

@freezed
class AdminUsersState with _$AdminUsersState {
  const factory AdminUsersState.initial() = _Initial;
  const factory AdminUsersState.loading() = _Loading;
  const factory AdminUsersState.loaded({
    required AdminUserListResponse users,
    String? searchQuery,
    @Default(false) bool isLoadingMore,
  }) = _Loaded;
  const factory AdminUsersState.error({
    required String message,
  }) = _Error;
} 