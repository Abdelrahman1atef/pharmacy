import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_state.freezed.dart';
@freezed
class CartState<T> with _$CartState {
  const factory CartState.initial() = Initial;
  const factory CartState.loading() = Loading;
  const factory CartState.success(T data) = Success<T>;
  const factory CartState.error(String e) = Error;
}
