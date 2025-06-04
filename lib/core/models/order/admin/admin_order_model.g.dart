// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminOrderModel _$AdminOrderModelFromJson(Map<String, dynamic> json) =>
    AdminOrderModel(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      userEmail: json['user_email'] as String,
      userPhone: json['user_phone'] as String,
      createdAt: json['created_at'] as String,
      totalPrice: json['total_price'] as String,
      status: $enumDecode(_$OrderStatusEnumMap, json['status']),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => AdminOrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      'total_price': instance.totalPrice,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'items': instance.items,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.processing: 'processing',
  OrderStatus.shipped: 'shipped',
  OrderStatus.delivered: 'delivered',
  OrderStatus.cancelled: 'cancelled',
};
