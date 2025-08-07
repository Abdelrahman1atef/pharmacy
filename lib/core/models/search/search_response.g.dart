// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) =>
    SearchResponse(
      productId: (json['product_id'] as num?)?.toInt(),
      productNameEn: json['product_name_en'] as String?,
      productNameAr: json['product_name_ar'] as String?,
      sellPrice: (json['sell_price'] as num?)?.toDouble(),
      productImageUrl: json['product_image_url'] as String?,
    );

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'product_name_en': instance.productNameEn,
      'product_name_ar': instance.productNameAr,
      'sell_price': instance.sellPrice,
      'product_image_url': instance.productImageUrl,
    };
