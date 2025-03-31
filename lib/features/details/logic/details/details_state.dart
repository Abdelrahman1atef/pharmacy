import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/network/api_exception.dart';

part 'details_state.freezed.dart';
@freezed
class DetailsState<T> with _$DetailsState {
  const factory DetailsState.initial() = Initial;
  const factory DetailsState.loading() = Loading;
  const factory DetailsState.success(T data) = Success<T>;
  const factory DetailsState.error(ApiException e) = Error;
}
