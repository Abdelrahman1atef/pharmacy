import 'package:json_annotation/json_annotation.dart';
part 'order_response.g.dart';
@JsonSerializable()
class OrderResponse {
 final String  message;
 final Order order;

 OrderResponse( this.message, this.order);
 factory OrderResponse.fromJson(json)=>_$OrderResponseFromJson(json);
}
@JsonSerializable()
class Order {
  @JsonKey(name:"id")
  final int  orderId;
  @JsonKey(name: "total_price")
  final double totalPrice;
  @JsonKey(name: "delivery_fee")
  final double deliveryFee;
  @JsonKey(name: "pharmacy_name")
  final String? pharmacyName;
  @JsonKey(name: "branch_id")
  final int? branchId;

  Order(this.orderId, this.totalPrice, this.deliveryFee, {this.pharmacyName, this.branchId});
  factory Order.fromJson(json)=>_$OrderFromJson(json);  
}










