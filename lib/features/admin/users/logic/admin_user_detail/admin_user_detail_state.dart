part of 'admin_user_detail_cubit.dart';

@freezed
class AdminUserDetailState with _$AdminUserDetailState {
  const factory AdminUserDetailState.initial() = _Initial;
  const factory AdminUserDetailState.loading() = _Loading;
  const factory AdminUserDetailState.loaded({
    required AdminUserDetailResponse user,
  }) = _Loaded;
  const factory AdminUserDetailState.error({
    required String message,
  }) = _Error;
} 