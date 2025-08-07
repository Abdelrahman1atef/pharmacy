// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) =>
    OrderResponse(
      json['message'] as String,
      Order.fromJson(json['order']),
    );

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'order': instance.order,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      (json['id'] as num).toInt(),
      (json['total_price'] as num).toDouble(),
      (json['delivery_fee'] as num).toDouble(),
      pharmacyName: json['pharmacy_name'] as String?,
      branchId: (json['branch_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.orderId,
      'total_price': instance.totalPrice,
      'delivery_fee': instance.deliveryFee,
      'pharmacy_name': instance.pharmacyName,
      'branch_id': instance.branchId,
    };
