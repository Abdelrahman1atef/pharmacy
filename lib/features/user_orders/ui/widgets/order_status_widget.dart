import 'package:flutter/material.dart';
import '../../../../../core/enum/order_status.dart';
import '../../../../../generated/l10n.dart';

class OrderStatusWidget extends StatelessWidget {
  final OrderStatus currentStatus;

  const OrderStatusWidget({
    super.key,
    required this.currentStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).orderStatus,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),
          _buildStatusIndicator(context),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(BuildContext context) {
    final statuses = _getOrderStatuses(context);
    final currentIndex = _getCurrentStatusIndex(context);

    return Row(
      children: [
        for (int i = 0; i < statuses.length; i++) ...[
          _buildStatusStep(
            context,
            status: statuses[i],
            isCompleted: i <= currentIndex,
            isActive: i == currentIndex,
            isLast: i == statuses.length - 1,
            isCanceled: currentStatus == OrderStatus.cancelled,
          ),
          if (i < statuses.length - 1)
            _buildConnector(isCompleted: i < currentIndex),
        ],
      ],
    );
  }

  Widget _buildStatusStep(
    BuildContext context, {
    required OrderStatusStep status,
    required bool isCompleted,
    required bool isActive,
    required bool isLast,
    required bool isCanceled,
  }) {
    // If order is canceled, make all statuses red
    Color statusColor = isCanceled
        ? Colors.red
        : isCompleted
            ? Colors.green
            : isActive
                ? Colors.blue
                : Colors.grey.shade300;

    Color borderColor = isCanceled
        ? Colors.red
        : isCompleted
            ? Colors.green
            : isActive
                ? Colors.blue
                : Colors.grey.shade400;

    Color textColor = isCanceled
        ? Colors.red
        : isCompleted || isActive
            ? Colors.black87
            : Colors.grey.shade600;
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: statusColor,
              border: Border.all(
                color: borderColor,
                width: 2,
              ),
            ),
            child: isCanceled
                ? const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 15,
                  )
                : isCompleted
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      )
                    : Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive ? Colors.white : Colors.transparent,
                        ),
                      ),
          ),
          const SizedBox(height: 8),
          Text(
            status.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnector({required bool isCompleted}) {
    Color connectorColor = currentStatus == OrderStatus.cancelled
        ? Colors.red
        : isCompleted
        ? Colors.green
        : Colors.grey.shade300;
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 32),
        decoration: BoxDecoration(
          color: connectorColor,
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }

  List<OrderStatusStep> _getOrderStatuses(context) {
    return [
      OrderStatusStep(OrderStatus.pending, S.of(context).orderStatusPending),
      OrderStatusStep(
          OrderStatus.preparing, S.of(context).orderStatusPreparing),
      OrderStatusStep(OrderStatus.shipped, S.of(context).orderStatusShipped),
      OrderStatusStep(
          OrderStatus.delivered, S.of(context).orderStatusDelivered),
      OrderStatusStep(
          OrderStatus.cancelled, S.of(context).orderStatusCancelled),
    ];
  }

  int _getCurrentStatusIndex(context) {
    final statuses = _getOrderStatuses(context);
    for (int i = 0; i < statuses.length; i++) {
      if (statuses[i].status == currentStatus) {
        return i;
      }
    }
    return 0;
  }
}

class OrderStatusStep {
  final OrderStatus status;
  final String title;

  OrderStatusStep(this.status, this.title);
}

// Simple version for just the status indicator
class SimpleOrderStatusIndicator extends StatelessWidget {
  final OrderStatus currentStatus;

  const SimpleOrderStatusIndicator({
    super.key,
    required this.currentStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: _getStatusColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _getStatusColor()),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getStatusColor(),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _getStatusText(context),
            style: TextStyle(
              color: _getStatusColor(),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (currentStatus) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.preparing:
        return Colors.purple;
      case OrderStatus.shipped:
        return Colors.blue;
      case OrderStatus.delivered:
        return Colors.green.shade700;
      case OrderStatus.cancelled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(context) {
    switch (currentStatus) {
      case OrderStatus.pending:
        return S.of(context).orderStatusPending;
      case OrderStatus.preparing:
        return S.of(context).orderStatusPreparing;
      case OrderStatus.shipped:
        return S.of(context).orderStatusShipped;
      case OrderStatus.delivered:
        return S.of(context).orderStatusDelivered;
      case OrderStatus.cancelled:
        return S.of(context).orderStatusCancelled;
      default:
        return S.of(context).orderStatusUndefined;
    }
  }
}
