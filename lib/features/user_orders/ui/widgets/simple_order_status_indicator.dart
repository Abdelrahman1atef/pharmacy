
// Simple version for just the status indicator
import 'package:flutter/material.dart';

import '../../../../core/enum/order_status.dart';
import '../../../../generated/l10n.dart';


class OrderProgressIndicator extends StatelessWidget {
  final OrderStatus currentStatus;
  final bool showLabels;
  final double height;
  final double width;
  final bool isVertical;

  const OrderProgressIndicator({
    super.key,
    required this.currentStatus,
    this.showLabels = true,
    this.height = 60,
    this.width = 400,
    this.isVertical = false,
  });

  @override
  Widget build(BuildContext context) {
    // Define the order progression (excluding cancelled as it's not part of normal flow)
    final List<OrderStatus> progressStatuses = [
      OrderStatus.pending,
      OrderStatus.preparing,
      OrderStatus.shipped,
      OrderStatus.delivered,
    ];

    // Calculate current progress
    int currentIndex = progressStatuses.indexOf(currentStatus);
    bool isCancelled = currentStatus == OrderStatus.cancelled;

    return Container(
      width: isVertical ? width : width,
      height: isVertical ? height : height,
      child: isVertical ? _buildVerticalLayout(progressStatuses, currentIndex, isCancelled, context)
          : _buildHorizontalLayout(progressStatuses, currentIndex, isCancelled, context),
    );
  }

  Widget _buildHorizontalLayout(List<OrderStatus> progressStatuses, int currentIndex, bool isCancelled, BuildContext context) {
    return Column(
      children: [
        // Progress bar
        Container(
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.shade300,
          ),
          child: Row(
            children: progressStatuses.asMap().entries.map((entry) {
              int index = entry.key;
              bool isActive = index <= currentIndex && !isCancelled;

              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: index < progressStatuses.length - 1 ? 2 : 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: isCancelled
                        ? Colors.red.shade300
                        : isActive
                        ? _getStatusColor(progressStatuses[index])
                        : Colors.grey.shade300,
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        if (showLabels) ...[
          const SizedBox(height: 12),
          // Status indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: progressStatuses.asMap().entries.map((entry) {
              int index = entry.key;
              OrderStatus status = entry.value;
              bool isActive = index <= currentIndex && !isCancelled;
              bool isCurrent = index == currentIndex && !isCancelled;

              return Column(
                children: [
                  // Status circle
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCancelled
                          ? Colors.red
                          : isActive
                          ? _getStatusColor(status)
                          : Colors.grey.shade300,
                      border: Border.all(
                        color: isCurrent
                            ? _getStatusColor(status)
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: isActive && !isCancelled
                        ? Icon(
                      index < currentIndex
                          ? Icons.check
                          : currentIndex == progressStatuses.length - 1
                          ? Icons.check
                          : Icons.circle,
                      size: 10,
                      color: Colors.white,
                    )
                        : null,
                  ),
                  const SizedBox(height: 4),
                  // Status label
                  Text(
                    _getStatusText(context, status),
                    style: TextStyle(
                      fontSize: 10,
                      color: isCancelled
                          ? Colors.red
                          : isActive
                          ? _getStatusColor(status)
                          : Colors.grey.shade600,
                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],

        // Show cancelled status if applicable
        if (isCancelled) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade300),
            ),
            child: Text(
              'Order Cancelled',
              style: TextStyle(
                color: Colors.red.shade700,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildVerticalLayout(List<OrderStatus> progressStatuses, int currentIndex, bool isCancelled, BuildContext context) {
    return Row(
      children: [
        // Vertical progress bar
        Container(
          width: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.shade300,
          ),
          child: Column(
            children: progressStatuses.asMap().entries.map((entry) {
              int index = entry.key;
              bool isActive = index <= currentIndex && !isCancelled;

              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: index < progressStatuses.length - 1 ? 2 : 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: isCancelled
                        ? Colors.red.shade300
                        : isActive
                        ? _getStatusColor(progressStatuses[index])
                        : Colors.grey.shade300,
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        if (showLabels) ...[
          const SizedBox(width: 12),
          // Status indicators
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: progressStatuses.asMap().entries.map((entry) {
                int index = entry.key;
                OrderStatus status = entry.value;
                bool isActive = index <= currentIndex && !isCancelled;
                bool isCurrent = index == currentIndex && !isCancelled;

                return Row(
                  children: [
                    // Status circle
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCancelled
                            ? Colors.red
                            : isActive
                            ? _getStatusColor(status)
                            : Colors.grey.shade300,
                        border: Border.all(
                          color: isCurrent
                              ? _getStatusColor(status)
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: isActive && !isCancelled
                          ? Icon(
                        index < currentIndex
                            ? Icons.check
                            : currentIndex == progressStatuses.length - 1
                            ? Icons.check
                            : Icons.circle,
                        size: 10,
                        color: Colors.white,
                      )
                          : null,
                    ),
                    const SizedBox(width: 8),
                    // Status label
                    Text(
                      _getStatusText(context, status),
                      style: TextStyle(
                        fontSize: 12,
                        color: isCancelled
                            ? Colors.red
                            : isActive
                            ? _getStatusColor(status)
                            : Colors.grey.shade600,
                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],

        // Show cancelled status if applicable (vertical)
        if (isCancelled && showLabels) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade300),
            ),
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(
                S.of(context).orderStatusCancelled,
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
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

  String _getStatusText(context,OrderStatus status) {
    switch (status) {
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
        return 'Unknown';
    }
  }
}


// Alternative compact version - just the progress bar
class CompactOrderProgressIndicator extends StatelessWidget {
  final OrderStatus currentStatus;
  final double width;
  final double height;

  const CompactOrderProgressIndicator({
    super.key,
    required this.currentStatus,
    this.width = 400,
    this.height = 8,
  });

  @override
  Widget build(BuildContext context) {
    final List<OrderStatus> progressStatuses = [
      OrderStatus.pending,
      OrderStatus.preparing,
      OrderStatus.shipped,
      OrderStatus.delivered,
    ];

    int currentIndex = progressStatuses.indexOf(currentStatus);
    bool isCancelled = currentStatus == OrderStatus.cancelled;
    double progress = isCancelled ? 1.0 : (currentIndex + 1) / progressStatuses.length;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height / 2),
        color: Colors.grey.shade300,
      ),
      child: FractionallySizedBox(
        alignment: AlignmentDirectional.centerStart,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height / 2),
            color: isCancelled
                ? Colors.red
                : _getStatusColor(currentStatus),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
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
}