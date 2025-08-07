import 'package:flutter/material.dart';
import 'package:pharmacy/core/enum/order_status.dart';
import 'package:pharmacy/core/models/admin_user/admin_user_detail_response.dart';
import 'package:pharmacy/core/themes/theme_mode/colors.dart';
import 'package:pharmacy/generated/l10n.dart';

class OrderHistoryList extends StatelessWidget {
  final List<OrderHistory> orderHistory;

  const OrderHistoryList({
    super.key,
    required this.orderHistory,
  });

  @override
  Widget build(BuildContext context) {
    if (orderHistory.isEmpty) {
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                size: 48,
                color: AppColors.black.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                S.of(context).noOrdersYet,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.black.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orderHistory.length,
      itemBuilder: (context, index) {
        final order = orderHistory[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _OrderHistoryCard(order: order),
        );
      },
    );
  }
}

class _OrderHistoryCard extends StatelessWidget {
  final OrderHistory order;

  const _OrderHistoryCard({
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: order.status.getStatusColor().withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                order.getStatusText(context),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: order.status.getStatusColor(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order #${order.orderId}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    _formatDate(order.createdAt),
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.black.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${order.totalPrice.toStringAsFixed(0)} EGP',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryLight,
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                _buildOrderInfo(S.of(context).paymentMethod, order.getPaymentMethodText(context)),
                const SizedBox(height: 8),
                _buildOrderInfo(S.of(context).deliveryMethod, order.getDeliveryMethodText(context)),
                const SizedBox(height: 8),
                _buildOrderInfo(S.of(context).address, order.addressStreet),
                const SizedBox(height: 16),
                Text(
                  '${S.of(context).items} (${order.items.length})',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 8),
                ...order.items.map((item) => _buildOrderItem(item)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderInfo(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.black.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItem(OrderHistoryItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backColor1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productNameEn,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
                Text(
                  item.productNameAr,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              item.unitType,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${item.quantity}x',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${item.unitPrice.toStringAsFixed(0)} EGP',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${item.itemTotal.toStringAsFixed(0)} EGP',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryLight,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
} 