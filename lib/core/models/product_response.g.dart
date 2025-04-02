// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      results: (json['results'] as List<dynamic>)
          .map((e) => Results.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: (json['count'] as num).toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
    };

Results _$ResultsFromJson(Map<String, dynamic> json) => Results(
      productId: (json['product_id'] as num?)?.toInt(),
      productCode: json['product_code'] as String?,
      productNameAr: json['product_name_ar'] as String?,
      productNameEn: json['product_name_en'] as String?,
      productUnit1: json['product_unit1'] as String?,
      sellPrice: (json['sell_price'] as num?)?.toDouble(),
      productUnit2: json['product_unit2'] as String?,
      productUnit1_2: (json['product_unit1_2'] as num?)?.toDouble(),
      unit2SellPrice: (json['unit2_sell_price'] as num?)?.toDouble(),
      productUnit3: json['product_unit3'] as String?,
      productUnit1_3: (json['product_unit1_3'] as num?)?.toDouble(),
      unit3SellPrice: (json['unit3_sell_price'] as num?)?.toDouble(),
      amount: (json['amount'] as num?)?.toInt(),
      productImageUrl: json['product_image_url'] as String?,
      productDescription: json['product_description'] as String?,
      company: json['company'] == null
          ? null
          : Company.fromJson(json['company'] as Map<String, dynamic>),
      productGroup: json['product_group'] == null
          ? null
          : ProductGroup.fromJson(
              json['product_group'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'product_id': instance.productId,
      'product_code': instance.productCode,
      'product_name_ar': instance.productNameAr,
      'product_name_en': instance.productNameEn,
      'product_unit1': instance.productUnit1,
      'sell_price': instance.sellPrice,
      'product_unit2': instance.productUnit2,
      'product_unit1_2': instance.productUnit1_2,
      'unit2_sell_price': instance.unit2SellPrice,
      'product_unit3': instance.productUnit3,
      'product_unit1_3': instance.productUnit1_3,
      'unit3_sell_price': instance.unit3SellPrice,
      'amount': instance.amount,
      'product_image_url': instance.productImageUrl,
      'product_description': instance.productDescription,
      'company': instance.company,
      'product_group': instance.productGroup,
    };

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      companyId: (json['company_id'] as num?)?.toInt(),
      coNameEn: json['co_name_en'] as String?,
      coNameAr: json['co_name_ar'] as String?,
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'company_id': instance.companyId,
      'co_name_en': instance.coNameEn,
      'co_name_ar': instance.coNameAr,
    };

ProductGroup _$ProductGroupFromJson(Map<String, dynamic> json) => ProductGroup(
      groupId: (json['group_id'] as num?)?.toInt(),
      groupNameEn: json['group_name_en'] as String?,
      groupNameAr: json['group_name_ar'] as String?,
    );

Map<String, dynamic> _$ProductGroupToJson(ProductGroup instance) =>
    <String, dynamic>{
      'group_id': instance.groupId,
      'group_name_en': instance.groupNameEn,
      'group_name_ar': instance.groupNameAr,
    };
