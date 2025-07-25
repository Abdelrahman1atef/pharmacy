import 'package:json_annotation/json_annotation.dart';

part 'customer_order_item_model.g.dart';

@JsonSerializable()
class CustomerOrderItemModel {
  @JsonKey(name: "product_id")
  final int productId;

  @JsonKey(name: "product_name_en")
  final String nameEn;

  @JsonKey(name: "product_name_ar")
  final String nameAr;

  @JsonKey(name: "sell_price")
  final String? sellPrice;

  @JsonKey(name: "unit_price")
  final String unitPrice;

  @JsonKey(name: "unit_type")
  final String unitType;

  final int quantity;

  @JsonKey(name: "item_total")
  final String itemTotal;

  @JsonKey(name: "product_images")
  final List<String>? productImages;

  CustomerOrderItemModel({
    required this.productId,
    required this.nameEn,
    required this.nameAr,
    this.sellPrice,
    required this.unitPrice,
    required this.unitType,
    required this.quantity,
    required this.itemTotal,
     this.productImages,
  });

  factory CustomerOrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerOrderItemModelFromJson(json);
  Map<String,dynamic> toJson()=>_$CustomerOrderItemModelToJson(this);
}
