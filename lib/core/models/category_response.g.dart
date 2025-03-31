// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      categoryId: (json['category_id'] as num?)?.toInt(),
      categoryNameAr: json['category_name_ar'] as String?,
      categoryImage: json['category_name_en'] as String?,
    );

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'category_name_ar': instance.categoryNameAr,
      'category_name_en': instance.categoryImage,
    };
