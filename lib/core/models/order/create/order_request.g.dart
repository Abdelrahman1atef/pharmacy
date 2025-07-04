// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequest _$OrderRequestFromJson(Map<String, dynamic> json) => OrderRequest(
      userId: (json['user_id'] as num).toInt(),
      products: json['products'] as List<dynamic>,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      paymentMethod: json['payment_method'] as String,
      deliveryMethod: json['delivery_method'] as String,
      isHomeDelivery: json['is_home_delivery'] as bool,
      callRequestEnabled: json['call_request_enabled'] as bool? ?? false,
      promoCode: json['promo_code'] as String?,
    );

Map<String, dynamic> _$OrderRequestToJson(OrderRequest instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'products': instance.products,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'payment_method': instance.paymentMethod,
      'delivery_method': instance.deliveryMethod,
      'is_home_delivery': instance.isHomeDelivery,
      'call_request_enabled': instance.callRequestEnabled,
      'promo_code': instance.promoCode,
    };
