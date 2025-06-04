import 'package:json_annotation/json_annotation.dart';
part 'order_response.g.dart';
@JsonSerializable()
class OrderResponse {
 final String status;
 final String  message;
 @JsonKey(name:"order_id")
 final int  orderId;
 @JsonKey(name: "total_amount")
 final double totalAmount;

 OrderResponse(this.status, this.message, this.orderId, this.totalAmount);
 factory OrderResponse.fromJson(json)=>_$OrderResponseFromJson(json);
}