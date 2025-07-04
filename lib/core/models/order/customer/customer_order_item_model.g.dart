// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerOrderItemModel _$CustomerOrderItemModelFromJson(
        Map<String, dynamic> json) =>
    CustomerOrderItemModel(
      productId: (json['product_id'] as num).toInt(),
      nameEn: json['product_name_en'] as String,
      nameAr: json['product_name_ar'] as String,
      sellPrice: json['sell_price'] as String?,
      unitPrice: json['unit_price'] as String,
      unitType: json['unit_type'] as String,
      quantity: (json['quantity'] as num).toInt(),
      itemTotal: json['item_total'] as String,
      productImages: (json['product_images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CustomerOrderItemModelToJson(
        CustomerOrderItemModel instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'product_name_en': instance.nameEn,
      'product_name_ar': instance.nameAr,
      'sell_price': instance.sellPrice,
      'unit_price': instance.unitPrice,
      'unit_type': instance.unitType,
      'quantity': instance.quantity,
      'item_total': instance.itemTotal,
      'product_images': instance.productImages,
    };
