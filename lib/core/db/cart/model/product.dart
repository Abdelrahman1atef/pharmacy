import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/product_response.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: 'product_id')
  int productId;

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

  @JsonKey(name: 'product_image_url')
  String? productImageUrl;

  int quantity;

  Product(
      {required this.productId,
      this.productNameAr,
      this.productNameEn,
      this.productUnit1,
      this.sellPrice,
      this.productUnit2,
      this.productUnit1_2,
      this.unit2SellPrice,
      this.productImageUrl,
      required this.quantity});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

extension ResultsToProduct on Results {
  Product toProduct({int quantity = 1}) {
    return Product(
      productId: productId ?? 0,
      productNameAr: productNameAr,
      productNameEn: productNameEn,
      productUnit1: productUnit1,
      sellPrice: sellPrice,
      productUnit2: productUnit2,
      productUnit1_2: productUnit1_2,
      unit2SellPrice: unit2SellPrice,
      productImageUrl: productImageUrl,
      quantity: quantity,
    );
  }
}
