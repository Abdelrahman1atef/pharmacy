import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy/core/network/api_exception.dart';
part 'search_state.freezed.dart';
@freezed
class SearchState<T> with _$SearchState {
  const factory SearchState.initial() = Initial;
  const factory SearchState.loading() = Loading;
  const factory SearchState.success(T data) = Success<T>;
  const factory SearchState.error(ApiException e) = Error;
}
