import 'package:flutter/material.dart';
import 'package:pharmacy/core/models/order/admin/admin_order_model.dart';
import 'package:pharmacy/generated/l10n.dart';

class AdminOrderCustomerInfo extends StatelessWidget {
  final AdminOrderModel order;
  const AdminOrderCustomerInfo({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            context,
            Icons.person,
            S.of(context).CustomerName,
            order.fullName,
          ),
          _buildInfoRow(
            context,
            Icons.email,
            S.of(context).CustomerEmail,
            order.userEmail ?? '',
          ),
          _buildInfoRow(
            context,
            Icons.phone,
            S.of(context).CustomerPhone,
            order.userPhone ?? '',
          ),
          if (order.userId != null)
            _buildInfoRow(
              context,
              Icons.badge,
              S.of(context).CustomerId,
              order.userId.toString(),
            ),
          if (order.addressName != null || order.addressStreet != null)
            _buildInfoRow(
              context,
              Icons.location_on,
              S.of(context).orderDetailsAddress,
              '${order.addressName ?? ''},\n ${order.addressStreet ?? ''}'.trim(),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : S.of(context).unknown,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 