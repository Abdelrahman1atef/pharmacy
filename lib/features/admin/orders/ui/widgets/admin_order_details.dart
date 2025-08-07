import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/core/models/order/admin/admin_order_model.dart';
import 'package:pharmacy/generated/l10n.dart';
import 'admin_order_customer_info.dart';
import 'admin_order_items_list.dart';
import 'admin_order_location_map.dart';
import 'admin_order_status_section.dart';
import 'package:pharmacy/core/enum/order_status.dart';

class AdminOrderDetails extends StatefulWidget {
  final AdminOrderModel order;
  final void Function(OrderStatus)? onStatusChanged;
  const AdminOrderDetails({required this.order, this.onStatusChanged, super.key});

  @override
  State<AdminOrderDetails> createState() => _AdminOrderDetailsState();
}

class _AdminOrderDetailsState extends State<AdminOrderDetails> {
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
            
            // Order Status Section (optimized to only rebuild on status change)
            AdminOrderStatusSection(
              order: widget.order,
              onStatusChanged: widget.onStatusChanged,
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
                    
                    // Pharmacy Information (for pharmacy pickup orders)
                    if (!widget.order.isHomeDelivery! && widget.order.pharmacyName != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).pharmacyPickup,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow(
                            context,
                            Icons.local_pharmacy,
                            S.of(context).pharmacyPickup,
                            widget.order.pharmacyName!,
                          ),
                          if (widget.order.branchId != null)
                            _buildInfoRow(
                              context,
                              Icons.store,
                              'Branch ID',
                              '${widget.order.branchId}',
                            ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    
                    // Location Map (only for home delivery)
                    if (widget.order.isHomeDelivery!)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).location,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          AdminOrderLocationMap(order: widget.order),
                          const SizedBox(height: 16),
                        ],
                      ),
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