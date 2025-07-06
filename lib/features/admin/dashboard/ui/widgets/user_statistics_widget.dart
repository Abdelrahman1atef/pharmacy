import 'package:flutter/material.dart';
import 'package:pharmacy/features/admin/dashboard/data/models/dashboard_response.dart';
import 'package:pharmacy/core/themes/theme_mode/colors.dart';
import 'package:pharmacy/generated/l10n.dart';

class UserStatisticsWidget extends StatelessWidget {
  final UserStatistics users;

  const UserStatisticsWidget({
    super.key,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.people, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  S.of(context).userStatistics,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildUserMetric(
                    context,
                    S.of(context).totalUsers,
                    users.totalUsers.toString(),
                    Icons.group,
                  ),
                ),
                Expanded(
                  child: _buildUserMetric(
                    context,
                    S.of(context).activeUsers,
                    users.activeUsers.toString(),
                    Icons.person,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildUserMetric(
                    context,
                    S.of(context).newThisMonth,
                    users.newUsersThisMonth.toString(),
                    Icons.person_add,
                  ),
                ),
                Expanded(
                  child: _buildUserMetric(
                    context,
                    S.of(context).growthRate,
                    '${users.userGrowthRate.toStringAsFixed(1)}%',
                    Icons.trending_up,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserMetric(BuildContext context, String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 24, color: AppColors.primary),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
} 