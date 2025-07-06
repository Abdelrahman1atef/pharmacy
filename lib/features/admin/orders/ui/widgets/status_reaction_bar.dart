import 'package:flutter/material.dart';
import 'package:pharmacy/core/enum/order_status.dart';
import 'package:pharmacy/generated/l10n.dart';

class StatusReactionBar extends StatefulWidget {
  final Offset position;
  final void Function(OrderStatus) onStatusSelected;
  final VoidCallback onDismiss;

  const StatusReactionBar({
    super.key,
    required this.position,
    required this.onStatusSelected,
    required this.onDismiss,
  });

  @override
  State<StatusReactionBar> createState() => _StatusReactionBarState();
}

class _StatusReactionBarState extends State<StatusReactionBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _scaleAnim = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return GestureDetector(
      onTap: widget.onDismiss,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              left: widget.position.dx,
              top: widget.position.dy,
              child: ScaleTransition(
                scale: _scaleAnim,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: OrderStatus.values.map((status) {
                      return GestureDetector(
                        onTap: () {
                          widget.onStatusSelected(status);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                backgroundColor: _getStatusColor(status),
                                child: Icon(
                                  _getStatusIcon(status),
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                status.getLocalizedDisplayName(s),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.cancelled:
        return Colors.red;
      case OrderStatus.preparing:
        return Colors.blue;
      case OrderStatus.shipped:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.delivered:
        return Icons.check_circle;
      case OrderStatus.pending:
        return Icons.schedule;
      case OrderStatus.cancelled:
        return Icons.cancel;
      case OrderStatus.preparing:
        return Icons.build;
      case OrderStatus.shipped:
        return Icons.local_shipping;
      default:
        return Icons.help;
    }
  }
} 