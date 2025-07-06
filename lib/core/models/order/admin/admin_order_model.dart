import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../enum/order_status.dart';
import '../../../enum/delivery_method.dart';
import '../../../enum/payment_method.dart';
import '../../../../generated/l10n.dart';
import 'admin_order_item_model.dart';

part 'admin_order_model.g.dart';

@JsonSerializable()
class AdminOrderModel {
  final int? id;

  @JsonKey(name: "user_id")
  final int? userId;

  @JsonKey(name: "first_name")
  final String? firstName;

  @JsonKey(name: "last_name")
  final String? lastName;

  @JsonKey(name: "user_email")
  final String? userEmail;

  @JsonKey(name: "user_phone")
  final String? userPhone;

  @JsonKey(name: "created_at")
  final String? createdAt;

  @JsonKey(
    name: "total_price",
    fromJson: _totalPriceFromJson,
    toJson: _totalPriceToJson,
  )
  final String? totalPrice;

  @JsonKey(name: "status")
  final OrderStatus? status;

  final List<AdminOrderItemModel>? items;

  @JsonKey(name: "address_name")
  final String? addressName;

  @JsonKey(name: "address_street")
  final String? addressStreet;

  final double? latitude;

  final double? longitude;

  @JsonKey(name: "payment_method")
  final PaymentMethod? paymentMethod;

  @JsonKey(name: "delivery_method")
  final DeliveryMethod? deliveryMethod;

  @JsonKey(name: "is_home_delivery")
  final bool? isHomeDelivery;

  @JsonKey(name: "call_request_enabled")
  final bool? callRequestEnabled;

  @JsonKey(name: "promo_code")
  final String? promoCode;

  AdminOrderModel({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.userEmail,
    this.userPhone,
    this.createdAt,
    this.totalPrice,
    this.status,
    this.items,
    this.addressName,
    this.addressStreet,
    this.latitude,
    this.longitude,
    this.paymentMethod,
    this.deliveryMethod,
    this.isHomeDelivery,
    this.callRequestEnabled,
    this.promoCode,
  });

  factory AdminOrderModel.fromJson(Map<String, dynamic> json) =>
      _$AdminOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminOrderModelToJson(this);

  // Custom converter for totalPrice to handle both String and double
  static String? _totalPriceFromJson(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is num) return value.toString();
    return null;
  }

  static dynamic _totalPriceToJson(String? value) => value;

  // Helper method to get full customer name
  String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();

  // Helper method to parse total price as double
  double get totalPriceAsDouble => double.tryParse(totalPrice ?? '0') ?? 0.0;

  String getStatusText(BuildContext context) {
    if (status == null) return 'Unknown';
    switch (status!) {
      case OrderStatus.pending:
        return S.of(context).orderStatusPending;
      case OrderStatus.preparing:
        return S.of(context).orderStatusPreparing;
      case OrderStatus.shipped:
        return S.of(context).orderStatusShipped;
      case OrderStatus.delivered:
        return S.of(context).orderStatusDelivered;
      case OrderStatus.cancelled:
        return S.of(context).orderStatusCancelled;
      default:
        return 'Unknown';
    }
  }

  String getDeliveryMethodText(BuildContext context) {
    if (deliveryMethod == null) return 'Unknown';
    return deliveryMethod!.getLocalizedDisplayName(S.of(context));
  }

  String getPaymentMethodText(BuildContext context) {
    if (paymentMethod == null) return 'Unknown';
    return paymentMethod!.getLocalizedDisplayName(S.of(context));
  }

  // Helper method to check if order is active
  bool get isActive => status != null && status != OrderStatus.cancelled && status != OrderStatus.delivered;
}
