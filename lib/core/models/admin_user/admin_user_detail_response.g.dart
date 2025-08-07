// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistoryItem _$OrderHistoryItemFromJson(Map<String, dynamic> json) =>
    OrderHistoryItem(
      productId: (json['product_id'] as num).toInt(),
      productNameEn: json['product_name_en'] as String,
      productNameAr: json['product_name_ar'] as String,
      unitPrice: (json['unit_price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      itemTotal: (json['item_total'] as num).toDouble(),
      unitType: json['unit_type'] as String,
    );

Map<String, dynamic> _$OrderHistoryItemToJson(OrderHistoryItem instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'product_name_en': instance.productNameEn,
      'product_name_ar': instance.productNameAr,
      'unit_price': instance.unitPrice,
      'quantity': instance.quantity,
      'item_total': instance.itemTotal,
      'unit_type': instance.unitType,
    };

OrderHistory _$OrderHistoryFromJson(Map<String, dynamic> json) => OrderHistory(
      orderId: (json['order_id'] as num).toInt(),
      createdAt: json['created_at'] as String,
      status: $enumDecode(_$OrderStatusEnumMap, json['status']),
      totalPrice: (json['total_price'] as num).toDouble(),
      paymentMethod:
          $enumDecodeNullable(_$PaymentMethodEnumMap, json['payment_method']),
      deliveryMethod:
          $enumDecodeNullable(_$DeliveryMethodEnumMap, json['delivery_method']),
      addressName: json['address_name'] as String,
      addressStreet: json['address_street'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      isHomeDelivery: json['is_home_delivery'] as bool,
      callRequestEnabled: json['call_request_enabled'] as bool,
      promoCode: json['promo_code'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderHistoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderHistoryToJson(OrderHistory instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'created_at': instance.createdAt,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'total_price': instance.totalPrice,
      'payment_method': _$PaymentMethodEnumMap[instance.paymentMethod],
      'delivery_method': _$DeliveryMethodEnumMap[instance.deliveryMethod],
      'address_name': instance.addressName,
      'address_street': instance.addressStreet,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'is_home_delivery': instance.isHomeDelivery,
      'call_request_enabled': instance.callRequestEnabled,
      'promo_code': instance.promoCode,
      'items': instance.items,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.preparing: 'preparing',
  OrderStatus.shipped: 'shipped',
  OrderStatus.delivered: 'delivered',
  OrderStatus.cancelled: 'cancelled',
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.cashOnDelivery: 'cash_on_delivery',
  PaymentMethod.debitCreditCard: 'debit_credit_card',
  PaymentMethod.debitCreditCardOnDelivery: 'debit_credit_card_on_delivery',
};

const _$DeliveryMethodEnumMap = {
  DeliveryMethod.homeDelivery: 'home_delivery',
  DeliveryMethod.pharmacyPickup: 'pharmacy_pickup',
};

AdminUserDetailResponse _$AdminUserDetailResponseFromJson(
        Map<String, dynamic> json) =>
    AdminUserDetailResponse(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      phone: json['phone'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      fullName: json['full_name'] as String,
      birthdate: json['birthdate'] as String?,
      gender: json['gender'] as String?,
      authType: json['auth_type'] as String,
      socialId: json['social_id'] as String?,
      profilePicture: json['profile_picture'] as String?,
      isActive: json['is_active'] as bool,
      isStaff: json['is_staff'] as bool,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      lastLogin: json['last_login'] as String?,
      totalOrders: (json['total_orders'] as num).toInt(),
      totalSpent: (json['total_spent'] as num).toDouble(),
      avgOrderValue: (json['avg_order_value'] as num).toDouble(),
      lastOrderDate: json['last_order_date'] as String?,
      firstOrderDate: json['first_order_date'] as String?,
      orderStatusDistribution:
          Map<String, int>.from(json['order_status_distribution'] as Map),
      orderHistory: (json['order_history'] as List<dynamic>)
          .map((e) => OrderHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdminUserDetailResponseToJson(
        AdminUserDetailResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phone': instance.phone,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'full_name': instance.fullName,
      'birthdate': instance.birthdate,
      'gender': instance.gender,
      'auth_type': instance.authType,
      'social_id': instance.socialId,
      'profile_picture': instance.profilePicture,
      'is_active': instance.isActive,
      'is_staff': instance.isStaff,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'last_login': instance.lastLogin,
      'total_orders': instance.totalOrders,
      'total_spent': instance.totalSpent,
      'avg_order_value': instance.avgOrderValue,
      'last_order_date': instance.lastOrderDate,
      'first_order_date': instance.firstOrderDate,
      'order_status_distribution': instance.orderStatusDistribution,
      'order_history': instance.orderHistory,
    };
