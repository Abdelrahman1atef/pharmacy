import 'package:json_annotation/json_annotation.dart';

part 'admin_order_item_model.g.dart';

@JsonSerializable()
class AdminOrderItemModel {
  @JsonKey(name: "product_id")
  final String productId;

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

  AdminOrderItemModel({
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

  factory AdminOrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$AdminOrderItemModelFromJson(json);

}
