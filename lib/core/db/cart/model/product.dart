import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../models/product/product_response.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: 'product_id')
  int productId;

  @JsonKey(name: 'product_name_ar')
  String? productNameAr;

  @JsonKey(name: 'product_name_en')
  String? productNameEn;
  
  /// Selected unit type (e.g., "علبة", "شريط")
  @JsonKey(name: 'selected_unit_type')
  String? selectedUnitType;
  
  /// Price of the selected unit type
  @JsonKey(name: 'selected_unit_price')
  double? selectedUnitPrice;

  @JsonKey(name: 'product_image_url')
  String? productImageUrl;
  
  @JsonKey(
    name: 'product_images',
    fromJson: Product._imagesFromJson,
    toJson: Product._imagesToJson,
  )
  List<String>? productImages;
  
  int quantity;

  Product({
    required this.productId,
    this.productNameAr,
    this.productNameEn,
    this.selectedUnitType,
    this.selectedUnitPrice,
    this.productImageUrl,
    required this.quantity,
    required this.productImages,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  static List<String>? _imagesFromJson(dynamic raw) {
    if (raw == null) return null;

    if (raw is List) {
      return raw.cast<String>();
    }

    if (raw is String) {
      try {
        final decoded = jsonDecode(raw);
        return decoded is List ? decoded.cast<String>() : null;
      } catch (_) {
        return null;
      }
    }

    return null;
  }

  static dynamic _imagesToJson(List<String>? images) {
    return images;
  }
}

extension ResultsToProduct on Results {
  /// Convert Results to Product with selected unit type and price
  Product toProduct({
    int quantity = 1,
    String? selectedUnitType,
    double? selectedUnitPrice,
  }) {
    // If no specific unit is selected, default to unit1
    final unitType = selectedUnitType ?? productUnit1 ?? "";
    final unitPrice = selectedUnitPrice ?? sellPrice ?? 0.0;
    
    return Product(
      productId: productId ?? 0,
      productNameAr: productNameAr,
      productNameEn: productNameEn,
      selectedUnitType: unitType,
      selectedUnitPrice: unitPrice,
      productImageUrl: productImageUrl,
      quantity: quantity,
      productImages: productImages,
    );
  }
}
