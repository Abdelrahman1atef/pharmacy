// Updated order_request.dart
import 'package:json_annotation/json_annotation.dart';

part 'order_request.g.dart';

@JsonSerializable()
class OrderRequest {
  @JsonKey(name: "user_id")
  final int userId;
  final List products;
  final String address;
  final double latitude;
  final double longitude;
  @JsonKey(name: "payment_method")
  final String? paymentMethod;

  // New delivery method fields
  @JsonKey(name: "delivery_method")
  final String deliveryMethod; // 'home_delivery' or 'pharmacy_pickup'

  @JsonKey(name: "is_home_delivery")
  final bool isHomeDelivery;

  @JsonKey(name: "call_request_enabled")
  final bool callRequestEnabled;

  @JsonKey(name: "promo_code")
  final String? promoCode;

  OrderRequest({
    required this.userId,
    required this.products,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.paymentMethod,
    required this.deliveryMethod,
    required this.isHomeDelivery,
    this.callRequestEnabled = false,
    this.promoCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'products': products.map((product) => product.toJson()).toList(),
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'payment_method': paymentMethod,
      'delivery_method': deliveryMethod,
      'is_home_delivery': isHomeDelivery,
      'call_request_enabled': callRequestEnabled,
      'promo_code': promoCode,
    };
  }

  factory OrderRequest.fromJson(Map<String, dynamic> json) => _$OrderRequestFromJson(json);
}