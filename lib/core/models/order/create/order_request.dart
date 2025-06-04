import 'package:pharmacy/core/db/cart/model/product.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../app_config_provider/logic/auth/model/data.dart';
part 'order_request.g.dart';
@JsonSerializable()
class OrderRequest {
  @JsonKey(name: "user_id")
  final int userId;
  final List<Product> products;

  OrderRequest({required this.userId, required this.products});

  Map<String,dynamic> toJson(){
    return {
      'user_id': userId, // Serialize the Data object
      'products': products.map((product) => product.toJson()).toList(), // Serialize each Product object
    };
  }
}