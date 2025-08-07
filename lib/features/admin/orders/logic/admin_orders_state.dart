import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/enum/order_status.dart';

part 'admin_orders_state.freezed.dart';
@freezed
class AdminOrdersState<T> with _$AdminOrdersState {
  const factory AdminOrdersState.initial() = Initial;
  const factory AdminOrdersState.loading() = Loading;
  const factory AdminOrdersState.success(T data, OrderStatus? filter) = Success;
  const factory AdminOrdersState.error() = Error;
}
