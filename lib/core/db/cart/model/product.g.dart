// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productId: (json['product_id'] as num).toInt(),
      productNameAr: json['product_name_ar'] as String?,
      productNameEn: json['product_name_en'] as String?,
      selectedUnitType: json['selected_unit_type'] as String?,
      selectedUnitPrice: (json['selected_unit_price'] as num?)?.toDouble(),
      productImageUrl: json['product_image_url'] as String?,
      quantity: (json['quantity'] as num).toInt(),
      productImages: Product._imagesFromJson(json['product_images']),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'product_id': instance.productId,
      'product_name_ar': instance.productNameAr,
      'product_name_en': instance.productNameEn,
      'selected_unit_type': instance.selectedUnitType,
      'selected_unit_price': instance.selectedUnitPrice,
      'product_image_url': instance.productImageUrl,
      'product_images': Product._imagesToJson(instance.productImages),
      'quantity': instance.quantity,
    };
