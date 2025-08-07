import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy/core/network/api_exception.dart';

part 'category_state.freezed.dart';

@freezed
class CategoryState<T> with _$CategoryState {
  const factory CategoryState.initial() = Initial;
  const factory CategoryState.loading() = Loading;
  const factory CategoryState.loadingFromCache() = LoadingFromCache;
  const factory CategoryState.success(T data) = Success<T>;
  const factory CategoryState.error(ApiException e) = Error;
}
