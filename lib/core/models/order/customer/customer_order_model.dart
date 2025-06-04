// import 'package:pharmacy/core/db/cart/model/product.dart';
//
// import '../order_entity.dart';
//
// class CustomerOrderModel {
//   final String id;
//   final double total;
//   final List<Product> items;
//   final String status;
//
//   CustomerOrderModel({
//     required this.id,
//     required this.total,
//     required this.items,
//     required this.status,
//   });
//
//   OrderEntity toEntity() {
//     return OrderEntity(
//       id: id,
//       total: total,
//       items: items.map((e) => e.toEntity()).toList(),
//       status: parseStatus(status), // Map string to enum
//     );
//   }
//
//   factory CustomerOrderModel.fromJson(Map<String, dynamic> json) {
//     return CustomerOrderModel(
//       id: json['id'],
//       total: json['total'],
//       items: (json['items'] as List)
//           .map((e) => CustomerOrderItemModel.fromJson(e))
//           .toList(),
//       status: json['status'],
//     );
//   }
// }
