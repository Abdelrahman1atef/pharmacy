// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productId: (json['product_id'] as num).toInt(),
      productNameAr: json['product_name_ar'] as String?,
      productNameEn: json['product_name_en'] as String?,
      productUnit1: json['product_unit1'] as String?,
      sellPrice: (json['sell_price'] as num?)?.toDouble(),
      productUnit2: json['product_unit2'] as String?,
      productUnit1_2: (json['product_unit1_2'] as num?)?.toDouble(),
      unit2SellPrice: (json['unit2_sell_price'] as num?)?.toDouble(),
      productImageUrl: json['product_image_url'] as String?,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'product_id': instance.productId,
      'product_name_ar': instance.productNameAr,
      'product_name_en': instance.productNameEn,
      'product_unit1': instance.productUnit1,
      'sell_price': instance.sellPrice,
      'product_unit2': instance.productUnit2,
      'product_unit1_2': instance.productUnit1_2,
      'unit2_sell_price': instance.unit2SellPrice,
      'product_image_url': instance.productImageUrl,
      'quantity': instance.quantity,
    };
