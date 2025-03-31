import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy/core/network/api_exception.dart';

part 'best_seller_state.freezed.dart';

@freezed
class BestSellerState<T> with _$BestSellerState {
  const factory BestSellerState.initial() = Initial;
  const factory BestSellerState.loading() = Loading;
  const factory BestSellerState.success(T data) = Success<T>;
  const factory BestSellerState.error(ApiException e) = Error;
}
