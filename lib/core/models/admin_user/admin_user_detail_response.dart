import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pharmacy/core/enum/payment_method.dart';
import 'package:pharmacy/core/enum/delivery_method.dart';
import 'package:pharmacy/core/enum/order_status.dart';
import 'package:pharmacy/generated/l10n.dart';

part 'admin_user_detail_response.g.dart';

@JsonSerializable()
class OrderHistoryItem {
  @JsonKey(name: 'product_id')
  final int productId;
  @JsonKey(name: 'product_name_en')
  final String productNameEn;
  @JsonKey(name: 'product_name_ar')
  final String productNameAr;
  @JsonKey(name: 'unit_price')
  final double unitPrice;
  final int quantity;
  @JsonKey(name: 'item_total')
  final double itemTotal;
  @JsonKey(name: 'unit_type')
  final String unitType;

  OrderHistoryItem({
    required this.productId,
    required this.productNameEn,
    required this.productNameAr,
    required this.unitPrice,
    required this.quantity,
    required this.itemTotal,
    required this.unitType,
  });

  factory OrderHistoryItem.fromJson(Map<String, dynamic> json) => _$OrderHistoryItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderHistoryItemToJson(this);
}

@JsonSerializable()
class OrderHistory {
  @JsonKey(name: 'order_id')
  final int orderId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  final OrderStatus status;
  @JsonKey(name: 'total_price')
  final double totalPrice;
  @JsonKey(name: 'payment_method')
  final PaymentMethod? paymentMethod;
  @JsonKey(name: 'delivery_method')
  final DeliveryMethod? deliveryMethod;
  @JsonKey(name: 'address_name')
  final String addressName;
  @JsonKey(name: 'address_street')
  final String addressStreet;
  final double latitude;
  final double longitude;
  @JsonKey(name: 'is_home_delivery')
  final bool isHomeDelivery;
  @JsonKey(name: 'call_request_enabled')
  final bool callRequestEnabled;
  @JsonKey(name: 'promo_code')
  final String? promoCode;
  final List<OrderHistoryItem> items;

  OrderHistory({
    required this.orderId,
    required this.createdAt,
    required this.status,
    required this.totalPrice,
    required this.paymentMethod,
    required this.deliveryMethod,
    required this.addressName,
    required this.addressStreet,
    required this.latitude,
    required this.longitude,
    required this.isHomeDelivery,
    required this.callRequestEnabled,
    this.promoCode,
    required this.items,
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) => _$OrderHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$OrderHistoryToJson(this);
  
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
}

@JsonSerializable()
class AdminUserDetailResponse {
  final int id;
  final String email;
  final String phone;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String? birthdate;
  final String? gender;
  @JsonKey(name: 'auth_type')
  final String authType;
  @JsonKey(name: 'social_id')
  final String? socialId;
  @JsonKey(name: 'profile_picture')
  final String? profilePicture;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'is_staff')
  final bool isStaff;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'last_login')
  final String? lastLogin;
  @JsonKey(name: 'total_orders')
  final int totalOrders;
  @JsonKey(name: 'total_spent')
  final double totalSpent;
  @JsonKey(name: 'avg_order_value')
  final double avgOrderValue;
  @JsonKey(name: 'last_order_date')
  final String? lastOrderDate;
  @JsonKey(name: 'first_order_date')
  final String? firstOrderDate;
  @JsonKey(name: 'order_status_distribution')
  final Map<String, int> orderStatusDistribution;
  @JsonKey(name: 'order_history')
  final List<OrderHistory> orderHistory;

  AdminUserDetailResponse({
    required this.id,
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.birthdate,
    required this.gender,
    required this.authType,
    this.socialId,
    required this.profilePicture,
    required this.isActive,
    required this.isStaff,
    required this.createdAt,
    required this.updatedAt,
    required this.lastLogin,
    required this.totalOrders,
    required this.totalSpent,
    required this.avgOrderValue,
    this.lastOrderDate,
    this.firstOrderDate,
    required this.orderStatusDistribution,
    required this.orderHistory,
  });

  factory AdminUserDetailResponse.fromJson(Map<String, dynamic> json) => _$AdminUserDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AdminUserDetailResponseToJson(this);
} 