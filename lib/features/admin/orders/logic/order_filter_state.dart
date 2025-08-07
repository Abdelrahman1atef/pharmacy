import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/enum/order_status.dart';

part 'order_filter_state.freezed.dart';

@freezed
class OrderFilterState with _$OrderFilterState {
  const factory OrderFilterState.initial() = Initial;
  const factory OrderFilterState.filtered(OrderStatus? status) = Filtered;
} 