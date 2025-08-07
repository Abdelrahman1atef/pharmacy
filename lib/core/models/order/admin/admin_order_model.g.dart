// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminOrderResponse _$AdminOrderResponseFromJson(Map<String, dynamic> json) =>
    AdminOrderResponse(
      count: (json['count'] as num).toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>)
          .map((e) => AdminOrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdminOrderResponseToJson(AdminOrderResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };

AdminOrderModel _$AdminOrderModelFromJson(Map<String, dynamic> json) =>
    AdminOrderModel(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      userEmail: json['user_email'] as String?,
      userPhone: json['user_phone'] as String?,
      createdAt: json['created_at'] as String?,
      totalPrice: AdminOrderModel._totalPriceFromJson(json['total_price']),
      status: $enumDecodeNullable(_$OrderStatusEnumMap, json['status']),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => AdminOrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      addressName: json['address_name'] as String?,
      addressStreet: json['address_street'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      paymentMethod:
          $enumDecodeNullable(_$PaymentMethodEnumMap, json['payment_method']),
      deliveryMethod:
          $enumDecodeNullable(_$DeliveryMethodEnumMap, json['delivery_method']),
      isHomeDelivery: json['is_home_delivery'] as bool?,
      callRequestEnabled: json['call_request_enabled'] as bool?,
      promoCode: json['promo_code'] as String?,
      pharmacyName: json['pharmacy_name'] as String?,
      branchId: (json['branch_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AdminOrderModelToJson(AdminOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'user_email': instance.userEmail,
      'user_phone': instance.userPhone,
      'created_at': instance.createdAt,
      'total_price': AdminOrderModel._totalPriceToJson(instance.totalPrice),
      'status': _$OrderStatusEnumMap[instance.status],
      'items': instance.items,
      'address_name': instance.addressName,
      'address_street': instance.addressStreet,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'payment_method': _$PaymentMethodEnumMap[instance.paymentMethod],
      'delivery_method': _$DeliveryMethodEnumMap[instance.deliveryMethod],
      'is_home_delivery': instance.isHomeDelivery,
      'call_request_enabled': instance.callRequestEnabled,
      'promo_code': instance.promoCode,
      'pharmacy_name': instance.pharmacyName,
      'branch_id': instance.branchId,
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
