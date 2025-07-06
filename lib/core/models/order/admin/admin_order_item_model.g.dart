// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminOrderItemModel _$AdminOrderItemModelFromJson(Map<String, dynamic> json) =>
    AdminOrderItemModel(
      productId: (json['product_id'] as num).toInt(),
      nameEn: json['product_name_en'] as String?,
      nameAr: json['product_name_ar'] as String?,
      sellPrice: AdminOrderItemModel._priceFromJson(json['sell_price']),
      unitPrice: AdminOrderItemModel._priceFromJson(json['unit_price']),
      unitType: json['unit_type'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      itemTotal: AdminOrderItemModel._priceFromJson(json['item_total']),
      productImages: (json['product_images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AdminOrderItemModelToJson(
        AdminOrderItemModel instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'product_name_en': instance.nameEn,
      'product_name_ar': instance.nameAr,
      'sell_price': AdminOrderItemModel._priceToJson(instance.sellPrice),
      'unit_price': AdminOrderItemModel._priceToJson(instance.unitPrice),
      'unit_type': instance.unitType,
      'quantity': instance.quantity,
      'item_total': AdminOrderItemModel._priceToJson(instance.itemTotal),
      'product_images': instance.productImages,
    };
