import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy/core/models/order/admin/admin_order_model.dart';

part 'user_orders_state.freezed.dart';
@freezed
class UserOrdersState<T> with _$UserOrdersState {
  const factory UserOrdersState.initial() = Initial;
  const factory UserOrdersState.loading() = Loading;
  const factory UserOrdersState.success(T data) = Success;
  const factory UserOrdersState.error() = Error;
}
