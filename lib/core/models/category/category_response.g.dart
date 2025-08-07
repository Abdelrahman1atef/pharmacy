// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      (json['count'] as num?)?.toInt(),
      json['next'] as String?,
      json['previous'] as String?,
      (json['results'] as List<dynamic>?)
          ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };

Results _$ResultsFromJson(Map<String, dynamic> json) => Results(
      categoryId: (json['category_id'] as num?)?.toInt(),
      categoryNameAr: json['category_name_ar'] as String?,
      categoryImage: json['category_name_en'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'category_id': instance.categoryId,
      'category_name_ar': instance.categoryNameAr,
      'category_name_en': instance.categoryImage,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };
