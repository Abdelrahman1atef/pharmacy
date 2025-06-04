// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) =>
    OrderResponse(
      json['status'] as String,
      json['message'] as String,
      (json['order_id'] as num).toInt(),
      (json['total_amount'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'order_id': instance.orderId,
      'total_amount': instance.totalAmount,
    };
