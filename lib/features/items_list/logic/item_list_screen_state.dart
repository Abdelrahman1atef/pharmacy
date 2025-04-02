import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy/core/network/api_exception.dart';

import '../../../core/models/product_response.dart';

part 'item_list_screen_state.freezed.dart';

@freezed
class ItemListScreenState<T> with _$ItemListScreenState {
  const factory ItemListScreenState.initial() = Initial;

  const factory ItemListScreenState.loading() = Loading;

  const factory ItemListScreenState.error(ApiException e, {ProductResponse? previousData}) = Error;

  const factory ItemListScreenState.loadingMore(T items) = LoadingMore<T>;

  const factory ItemListScreenState.success(T item) = Success<T>;
}
