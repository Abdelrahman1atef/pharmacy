import 'package:json_annotation/json_annotation.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  List<Results> results = [];
  final int count;
  final String? next;
  final String? previous;
  ProductResponse({required this.results, required this.count, this.next, this.previous});

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}

@JsonSerializable()
class Results {
  @JsonKey(name: 'product_id')
  int? productId;

  @JsonKey(name: 'product_code')
  String? productCode;

  @JsonKey(name: 'product_name_ar')
  String? productNameAr;

  @JsonKey(name: 'product_name_en')
  String? productNameEn;

  @JsonKey(name: 'product_unit1')
  String? productUnit1;

  @JsonKey(name: 'sell_price')
  double? sellPrice;

  @JsonKey(name: 'product_unit2')
  String? productUnit2;

  @JsonKey(name: 'product_unit1_2')
  double? productUnit1_2;

  @JsonKey(name: 'unit2_sell_price')
  double? unit2SellPrice;

  @JsonKey(name: 'product_unit3')
  String? productUnit3;

  @JsonKey(name: 'product_unit1_3')
  double? productUnit1_3;

  @JsonKey(name: 'unit3_sell_price')
  double? unit3SellPrice;

  @JsonKey(name: 'stock_amount')
  int? stockAmount;

  @JsonKey(name: 'product_image_url')
  String? productImageUrl;

  @JsonKey(name: 'product_description')
  ProductDescription? productDescription;

  @JsonKey(name: 'company')
  Company? company;

  @JsonKey(name: 'product_group')
  ProductGroup? productGroup;

  @JsonKey(name: 'product_images')
  List<String>? productImages;

  Results({
    required this.productId,
    required this.productCode,
    required this.productNameAr,
    required this.productNameEn,
    required this.productUnit1,
    required this.sellPrice,
    required this.productUnit2,
    required this.productUnit1_2,
    required this.unit2SellPrice,
    required this.productUnit3,
    required this.productUnit1_3,
    required this.unit3SellPrice,
    required this.stockAmount,
    this.productImageUrl,
    required this.productDescription,
    required this.company,
    required this.productGroup,
    required this.productImages,
  });

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);
      
  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}

@JsonSerializable()
class ProductDescription {
  @JsonKey(name: 'pd_name_ar')
  String? pdNameAr;

  @JsonKey(name: 'pd_name_en')
  String? pdNameEn;

  ProductDescription({
    required this.pdNameAr,
    required this.pdNameEn,
  });

  factory ProductDescription.fromJson(Map<String, dynamic> json) =>
      _$ProductDescriptionFromJson(json);
      
  Map<String, dynamic> toJson() => _$ProductDescriptionToJson(this);
}

@JsonSerializable()
class Company {
  @JsonKey(name: 'company_id')
  int? companyId;

  @JsonKey(name: 'co_name_en')
  String? coNameEn;

  @JsonKey(name: 'co_name_ar')
  String? coNameAr;

  Company({
    required this.companyId,
    required this.coNameEn,
    required this.coNameAr,
  });

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
      
  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}

@JsonSerializable()
class ProductGroup {
  @JsonKey(name: 'group_id')
  int? groupId;

  @JsonKey(name: 'group_name_en')
  String? groupNameEn;

  @JsonKey(name: 'group_name_ar')
  String? groupNameAr;

  ProductGroup({
    required this.groupId,
    required this.groupNameEn,
    required this.groupNameAr,
  });

  factory ProductGroup.fromJson(Map<String, dynamic> json) =>
      _$ProductGroupFromJson(json);
      
  Map<String, dynamic> toJson() => _$ProductGroupToJson(this);
}
