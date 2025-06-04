import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy/core/network/api_exception.dart';

import '../../../../core/models/order/create/order_response.dart';
part 'order_state.freezed.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState.initial() = Initial;
  const factory OrderState.loading() = Loading;
  const factory OrderState.success(OrderResponse data) = Success;
  const factory OrderState.error(ApiException e) = Error;
}
