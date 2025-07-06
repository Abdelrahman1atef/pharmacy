import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy/core/network/api_exception.dart';

part 'see_our_products_state.freezed.dart';

@freezed
class SeeOurProductsState with _$SeeOurProductsState {
  const factory SeeOurProductsState.initial() = Initial;
  const factory SeeOurProductsState.loading() = Loading;
  const factory SeeOurProductsState.success(dynamic data) = Success;
  const factory SeeOurProductsState.error(ApiException e) = Error;
} 