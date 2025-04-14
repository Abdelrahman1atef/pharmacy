import 'package:json_annotation/json_annotation.dart';

part 'cart_item.g.dart';

@JsonSerializable()
class CartItem {
  @JsonKey(name: "product_id")
 int productId;
  @JsonKey(name: "store_id")
 int storeId;
  @JsonKey(name: "quantity")
  int quantity;

 CartItem({required this.productId, required this.storeId, required this.quantity});
}