import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/core/enum/order_status.dart';
import 'package:pharmacy/features/admin/orders/logic/admin_orders_cubit.dart';
import 'package:pharmacy/features/admin/orders/logic/admin_orders_state.dart';
import 'package:pharmacy/generated/l10n.dart';

class OrderStatusFilter extends StatelessWidget {
  const OrderStatusFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminOrdersCubit, AdminOrdersState>(
      builder: (context, state) {
        final currentFilter = context.read<AdminOrdersCubit>().currentFilter;
        
        return Container(
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              // All orders filter
              _buildFilterChip(
                context,
                label: 'All',
                isSelected: currentFilter == null,
                onTap: () => context.read<AdminOrdersCubit>().clearFilter(),
              ),
              const SizedBox(width: 8),
              // Pending filter
              _buildFilterChip(
                context,
                label: S.of(context).orderStatusPending,
                isSelected: currentFilter == OrderStatus.pending,
                onTap: () => context.read<AdminOrdersCubit>().filterByStatus(OrderStatus.pending),
                color: OrderStatus.pending.getStatusColor(),
              ),
              const SizedBox(width: 8),
              // Preparing filter
              _buildFilterChip(
                context,
                label: S.of(context).orderStatusPreparing,
                isSelected: currentFilter == OrderStatus.preparing,
                onTap: () => context.read<AdminOrdersCubit>().filterByStatus(OrderStatus.preparing),
                color: OrderStatus.preparing.getStatusColor(),
              ),
              const SizedBox(width: 8),
              // Shipped filter
              _buildFilterChip(
                context,
                label: S.of(context).orderStatusShipped,
                isSelected: currentFilter == OrderStatus.shipped,
                onTap: () => context.read<AdminOrdersCubit>().filterByStatus(OrderStatus.shipped),
                color: OrderStatus.shipped.getStatusColor(),
              ),
              const SizedBox(width: 8),
              // Delivered filter
              _buildFilterChip(
                context,
                label: S.of(context).orderStatusDelivered,
                isSelected: currentFilter == OrderStatus.delivered,
                onTap: () => context.read<AdminOrdersCubit>().filterByStatus(OrderStatus.delivered),
                color: OrderStatus.delivered.getStatusColor(),
              ),
              const SizedBox(width: 8),
              // Cancelled filter
              _buildFilterChip(
                context,
                label: S.of(context).orderStatusCancelled,
                isSelected: currentFilter == OrderStatus.cancelled,
                onTap: () => context.read<AdminOrdersCubit>().filterByStatus(OrderStatus.cancelled),
                color: OrderStatus.cancelled.getStatusColor(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? (color ?? Theme.of(context).primaryColor)
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: color ?? Theme.of(context).primaryColor, width: 2)
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 