// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequest _$OrderRequestFromJson(Map<String, dynamic> json) => OrderRequest(
      userId: (json['user_id'] as num).toInt(),
      products: json['products'] as List<dynamic>,
      address: json['address'] as String?,
      addressName: json['address_name'] as String?,
      addressStreet: json['address_street'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      paymentMethod:
          $enumDecodeNullable(_$PaymentMethodEnumMap, json['payment_method']),
      deliveryMethod:
          $enumDecode(_$DeliveryMethodEnumMap, json['delivery_method']),
      isHomeDelivery: json['is_home_delivery'] as bool,
      deliveryFee: (json['delivery_fee'] as num?)?.toDouble(),
      callRequestEnabled: json['call_request_enabled'] as bool? ?? false,
      promoCode: json['promo_code'] as String?,
      branchId: (json['branch_id'] as num?)?.toInt(),
      pharmacyName: json['pharmacy_name'] as String?,
    );

Map<String, dynamic> _$OrderRequestToJson(OrderRequest instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'products': instance.products,
      'address': instance.address,
      'address_name': instance.addressName,
      'address_street': instance.addressStreet,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'payment_method': _$PaymentMethodEnumMap[instance.paymentMethod],
      'delivery_method': _$DeliveryMethodEnumMap[instance.deliveryMethod]!,
      'is_home_delivery': instance.isHomeDelivery,
      'delivery_fee': instance.deliveryFee,
      'call_request_enabled': instance.callRequestEnabled,
      'promo_code': instance.promoCode,
      'branch_id': instance.branchId,
      'pharmacy_name': instance.pharmacyName,
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
