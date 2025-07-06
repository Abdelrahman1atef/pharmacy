import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/core/models/order/admin/admin_order_model.dart';
import 'package:pharmacy/features/admin/orders/logic/admin_orders_cubit.dart';
import 'package:pharmacy/generated/l10n.dart';
import 'admin_order_customer_info.dart';
import 'admin_order_items_list.dart';
import 'package:pharmacy/core/enum/order_status.dart';
import 'status_reaction_bar.dart';

class AdminOrderDetails extends StatefulWidget {
  final AdminOrderModel order;
  final void Function(OrderStatus)? onStatusChanged;
  const AdminOrderDetails({required this.order, this.onStatusChanged, super.key});

  @override
  State<AdminOrderDetails> createState() => _AdminOrderDetailsState();
}

class _AdminOrderDetailsState extends State<AdminOrderDetails> {
  final GlobalKey _statusKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  void _showStatusReactionBar() {
    final contextForKey = _statusKey.currentContext;
    if (contextForKey == null) return;
    final RenderBox? renderBox = contextForKey.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => StatusReactionBar(
        position: Offset(offset.dx, offset.dy - 80),
        onStatusSelected: (status) {
          _removeOverlay();
          final orderId = widget.order.id;
          final cubit = context.read<AdminOrdersCubit?>();
          if (orderId != null && cubit != null) {
            cubit.updateOrdersStatus(orderId, status);
          }
          if (widget.onStatusChanged != null) {
            widget.onStatusChanged!(status);
          }
        },
        onDismiss: _removeOverlay,
      ),
    );
    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${S.of(context).orderDetails} #${widget.order.id}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(),
            
            // Order Status (with long press)
            GestureDetector(
              key: _statusKey,
              onTap: _showStatusReactionBar,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getStatusColor(widget.order.status?.name),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getStatusIcon(widget.order.status?.name),
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${S.of(context).orderStatus}: ${widget.order.getStatusText(context)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.touch_app, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Info
                    _buildInfoRow(
                      context,
                      Icons.calendar_today,
                      S.of(context).CreatedAt,
                      _formatDate(context, widget.order.createdAt),
                    ),
                    _buildInfoRow(
                      context,
                      Icons.attach_money,
                      S.of(context).total,
                      '${widget.order.totalPrice} ${S.of(context).pound}',
                    ),
                    const SizedBox(height: 16),
              
                    // Customer Info
                    Text(
                      S.of(context).CustomerName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AdminOrderCustomerInfo(order: widget.order),
                    const SizedBox(height: 16),
              
                    // Order Items
                    Text(
                      '${S.of(context).product}${S.of(context).ofProducts}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AdminOrderItemsList(items: widget.order.items ?? []),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'delivered':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      case 'preparing':
        return Colors.blue;
      case 'shipped':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String? status) {
    switch (status) {
      case 'delivered':
        return Icons.check_circle;
      case 'pending':
        return Icons.schedule;
      case 'cancelled':
        return Icons.cancel;
      case 'preparing':
        return Icons.build;
      case 'shipped':
        return Icons.local_shipping;
      default:
        return Icons.help;
    }
  }

  String _formatDate(BuildContext context, String? createdAt) {
    if (createdAt == null || createdAt.isEmpty) {
      return S.of(context).unknown;
    }

    DateTime? dateTime;
    // Try ISO 8601 first
    try {
      dateTime = DateTime.parse(createdAt);
    } catch (_) {
      // Try European format if ISO fails
      try {
        dateTime = DateFormat('dd/MM/yyyy HH:mm').parse(createdAt);
      } catch (_) {}
    }

    if (dateTime != null) {
      // Display in European format (or any format you want)
      return DateFormat('dd/MM/yyyy hh:mm a').format(dateTime);
    } else {
      // Fallback: show the original string
      return createdAt;
    }
  }
} 