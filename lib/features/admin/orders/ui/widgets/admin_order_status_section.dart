import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/core/enum/order_status.dart';
import 'package:pharmacy/core/models/order/admin/admin_order_model.dart';
import 'package:pharmacy/features/admin/orders/logic/admin_orders_cubit.dart';
import 'package:pharmacy/generated/l10n.dart';
import 'status_reaction_bar.dart';

class AdminOrderStatusSection extends StatefulWidget {
  final AdminOrderModel order;
  final void Function(OrderStatus)? onStatusChanged;

  const AdminOrderStatusSection({
    required this.order,
    this.onStatusChanged,
    super.key,
  });

  @override
  State<AdminOrderStatusSection> createState() => _AdminOrderStatusSectionState();
}

class _AdminOrderStatusSectionState extends State<AdminOrderStatusSection> {
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
    return GestureDetector(
      key: _statusKey,
      onTap: _showStatusReactionBar,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.order.status?.getStatusColor() ?? Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              widget.order.status?.getStatusIcon() ?? Icons.help,
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
    );
  }
} 