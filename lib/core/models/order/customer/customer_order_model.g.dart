// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerOrderModel _$CustomerOrderModelFromJson(Map<String, dynamic> json) =>
    CustomerOrderModel(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      userEmail: json['user_email'] as String,
      userPhone: json['user_phone'] as String,
      createdAt: json['created_at'] as String,
      totalPrice: (json['total_price'] as num).toDouble(),
      status: $enumDecode(_$OrderStatusEnumMap, json['status']),
      items: (json['items'] as List<dynamic>?)
          ?.map(
              (e) => CustomerOrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerOrderModelToJson(CustomerOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'user_email': instance.userEmail,
      'user_phone': instance.userPhone,
      'created_at': instance.createdAt,
      'total_price': instance.totalPrice,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'items': instance.items,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.preparing: 'preparing',
  OrderStatus.shipped: 'shipped',
  OrderStatus.delivered: 'delivered',
  OrderStatus.cancelled: 'cancelled',
};
