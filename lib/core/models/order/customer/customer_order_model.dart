import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../generated/l10n.dart';
import '../../../enum/order_status.dart';
import '../../../enum/delivery_method.dart';
import '../../../enum/payment_method.dart';
import 'customer_order_item_model.dart';

part 'customer_order_model.g.dart';

@JsonSerializable()
class CustomerOrderResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<CustomerOrderModel> results;

  CustomerOrderResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory CustomerOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerOrderResponseToJson(this);
}

@JsonSerializable()
class CustomerOrderModel {
  final int id;

  @JsonKey(name: "user_id")
  final int userId;

  @JsonKey(name: "first_name")
  final String firstName;

  @JsonKey(name: "last_name")
  final String lastName;

  @JsonKey(name: "user_email")
  final String userEmail;

  @JsonKey(name: "user_phone")
  final String userPhone;

  @JsonKey(name: "created_at")
  final String createdAt;

  @JsonKey(name: "total_price")
  final double totalPrice;

  @JsonKey(name: "status")
  final OrderStatus status;

  final List<CustomerOrderItemModel>? items;

  // New fields from your JSON
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
  final bool isHomeDelivery;

  @JsonKey(name: "call_request_enabled")
  final bool? callRequestEnabled;

  @JsonKey(name: "promo_code")
  final String? promoCode;

  @JsonKey(name: "pharmacy_name")
  final String? pharmacyName;

  @JsonKey(name: "branch_id")
  final int? branchId;

  CustomerOrderModel( {
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.userEmail,
    required this.userPhone,
    required this.createdAt,
    required this.totalPrice,
    required this.status,
    this.items,
    this.addressName,
    this.addressStreet,
    this.latitude,
    this.longitude,
    this.paymentMethod,
    this.deliveryMethod,
    required this.isHomeDelivery,
    this.callRequestEnabled,
    this.promoCode,
    this.pharmacyName,
    this.branchId,
  });

  factory CustomerOrderModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerOrderModelToJson(this);

  // Helper method to get full customer name
  String get fullName => '$firstName $lastName';

  String getStatusText(BuildContext context) {
    switch (status) {
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
  bool get isActive => status != OrderStatus.cancelled && status != OrderStatus.delivered;
}
