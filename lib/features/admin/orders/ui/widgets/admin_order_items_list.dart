import 'package:flutter/material.dart';
import 'package:pharmacy/core/models/order/admin/admin_order_item_model.dart';
import 'package:pharmacy/generated/l10n.dart';

class AdminOrderItemsList extends StatelessWidget {
  final List<AdminOrderItemModel> items;
  const AdminOrderItemsList({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 8),
            Text(
              S.of(context).noItemInCart,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.medication, color: Colors.grey),
            ),
            title: Text(
              item.nameEn ?? item.nameAr ?? S.of(context).unknown,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${S.of(context).unitType}: ${item.unitType ?? S.of(context).unknown}'),
                Text('${S.of(context).quantity}: ${item.quantity}'),
                if (item.unitPrice != null)
                  Text('${S.of(context).unitType}: ${item.unitType}'),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${S.of(context).itemTotal}:',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  '${item.itemTotal} ${S.of(context).pound}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 