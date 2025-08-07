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
  final String? address;
  @JsonKey(name: "address_name")
  final String? addressName;
  @JsonKey(name: "address_street")
  final String? addressStreet;
  final double? latitude;
  final double? longitude;
  @JsonKey(name: "payment_method")
  final PaymentMethod? paymentMethod;

  // New delivery method fields
  @JsonKey(name: "delivery_method")
  final DeliveryMethod deliveryMethod;

  @JsonKey(name: "is_home_delivery")
  final bool isHomeDelivery;

  @JsonKey(name: "delivery_fee")
  final double? deliveryFee;
  
  @JsonKey(name: "call_request_enabled")
  final bool callRequestEnabled;

  @JsonKey(name: "promo_code")
  final String? promoCode;

  @JsonKey(name: "branch_id")
  final int? branchId;

  @JsonKey(name: "pharmacy_name")
  final String? pharmacyName;

  OrderRequest({
    required this.userId,
    required this.products,
    this.address,
    this.addressName,
    this.addressStreet,
    this.latitude,
    this.longitude,
    required this.paymentMethod,
    required this.deliveryMethod,
    required this.isHomeDelivery,
    this.deliveryFee,
    this.callRequestEnabled = false,
    this.promoCode,
    this.branchId,
    this.pharmacyName,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'products': products.map((product) => product.toJson()).toList(),
      'address': address ?? '',
      'address_name': addressName ?? '',
      'address_street': addressStreet ?? '',
      'latitude': latitude ?? 0.0,
      'longitude': longitude ?? 0.0,
      'payment_method': paymentMethod?.displayName,
      'delivery_method': deliveryMethod.displayName,
      'is_home_delivery': isHomeDelivery,
      'call_request_enabled': callRequestEnabled,
      'promo_code': promoCode,
      'delivery_fee': deliveryFee,
      'branch_id': branchId,
      'pharmacy_name': pharmacyName,
    };
  }

  factory OrderRequest.fromJson(Map<String, dynamic> json) => _$OrderRequestFromJson(json);
}