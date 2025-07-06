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
}