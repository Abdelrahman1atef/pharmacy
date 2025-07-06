// Updated order_request.dart
import 'package:json_annotation/json_annotation.dart';
import '../../../enum/delivery_method.dart';
import '../../../enum/payment_method.dart';

part 'order_request.g.dart';

@JsonSerializable()
class OrderRequest {
  @JsonKey(name: "user_id")
  final int userId;
  final List products;
  final String address;
  @JsonKey(name: "address_name")
  final String addressName;
  @JsonKey(name: "address_street")
  final String addressStreet;
  final double latitude;
  final double longitude;
  @JsonKey(name: "payment_method")
  final PaymentMethod? paymentMethod;

  // New delivery method fields
  @JsonKey(name: "delivery_method")
  final DeliveryMethod deliveryMethod;

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
    required this.addressName,
    required this.addressStreet,
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
      'address_name': addressName,
      'address_street': addressStreet,
      'latitude': latitude,
      'longitude': longitude,
      'payment_method': paymentMethod?.displayName,
      'delivery_method': deliveryMethod.displayName,
      'is_home_delivery': isHomeDelivery,
      'call_request_enabled': callRequestEnabled,
      'promo_code': promoCode,
    };
  }

  factory OrderRequest.fromJson(Map<String, dynamic> json) => _$OrderRequestFromJson(json);
}