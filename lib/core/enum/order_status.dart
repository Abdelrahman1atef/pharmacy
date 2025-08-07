import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

enum OrderStatus {
  pending,
  preparing,
  shipped,
  delivered,
  cancelled,
}

extension OrderStatusLocalization on OrderStatus {
  String getLocalizedDisplayName(S s) {
    switch (this) {
      case OrderStatus.pending:
        return s.orderStatusPending;
      case OrderStatus.preparing:
        return s.orderStatusPreparing;
      case OrderStatus.shipped:
        return s.orderStatusShipped;
      case OrderStatus.delivered:
        return s.orderStatusDelivered;
      case OrderStatus.cancelled:
        return s.orderStatusCancelled;
      default:
        return s.unknown;
    }
  }

  Color getStatusColor() {
    switch (this) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.preparing:
        return Colors.blue;
      case OrderStatus.shipped:
        return Colors.purple;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  IconData getStatusIcon() {
    switch (this) {
      case OrderStatus.pending:
        return Icons.schedule;
      case OrderStatus.preparing:
        return Icons.build;
      case OrderStatus.shipped:
        return Icons.local_shipping;
      case OrderStatus.delivered:
        return Icons.check_circle;
      case OrderStatus.cancelled:
        return Icons.cancel;
    }
  }
}