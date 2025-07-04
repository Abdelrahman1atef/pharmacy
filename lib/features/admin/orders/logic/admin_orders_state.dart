import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy/core/models/order/admin/admin_order_model.dart';

part 'admin_orders_state.freezed.dart';
@freezed
class AdminOrdersState<T> with _$AdminOrdersState {
  const factory AdminOrdersState.initial() = Initial;
  const factory AdminOrdersState.loading() = Loading;
  const factory AdminOrdersState.success(T data) = Success;
  const factory AdminOrdersState.error() = Error;
}
