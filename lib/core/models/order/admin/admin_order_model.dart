import 'package:json_annotation/json_annotation.dart';

import '../../../enum/order_status.dart';
import 'admin_order_item_model.dart';

part 'admin_order_model.g.dart';

@JsonSerializable()
class AdminOrderModel {
  final int id;

  @JsonKey(name: "user_id")
  final int userId;

  @JsonKey(name: "first_name")
  final String firstName;

  @JsonKey(name: "last_name")
  final String lastName;

  @JsonKey(name: "user_email")
  final String userEmail;

  @JsonKey(name: "user_phone")
  final String userPhone;

  @JsonKey(name: "created_at")
  final String createdAt;

  @JsonKey(name: "total_price")
  final String totalPrice;

  final OrderStatus status;

  final List<AdminOrderItemModel>? items;

  AdminOrderModel({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.userEmail,
    required this.userPhone,
    required this.createdAt,
    required this.totalPrice,
    required this.status,
    required this.items,
  });

  factory AdminOrderModel.fromJson(Map<String, dynamic> json) =>
      _$AdminOrderModelFromJson(json);

}
