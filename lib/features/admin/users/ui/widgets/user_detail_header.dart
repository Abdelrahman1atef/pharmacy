import 'package:flutter/material.dart';
import 'package:pharmacy/core/models/admin_user/admin_user_detail_response.dart';
import 'package:pharmacy/core/themes/theme_mode/colors.dart';
import 'package:pharmacy/generated/l10n.dart';

class UserDetailHeader extends StatelessWidget {
  final AdminUserDetailResponse user;

  const UserDetailHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primaryLight,
              child: Text(
                user.fullName.isNotEmpty
                    ? user.fullName[0].toUpperCase()
                    : 'U',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              user.fullName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: user.isActive
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                user.isActive ? S.of(context).activeUser : S.of(context).inactiveUser,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: user.isActive ? Colors.green : Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoRow(S.of(context).email, user.email, Icons.email),
            const SizedBox(height: 12),
            _buildInfoRow(S.of(context).phone, user.phone, Icons.phone),
            const SizedBox(height: 12),
            _buildInfoRow(S.of(context).gender, user.gender, Icons.person),
            const SizedBox(height: 12),
            _buildInfoRow(S.of(context).birthDate, _formatDate(user.birthdate), Icons.cake),
            const SizedBox(height: 12),
            _buildInfoRow(S.of(context).authType, user.authType, Icons.security),
            const SizedBox(height: 12),
            _buildInfoRow(S.of(context).memberSince, _formatDate(user.createdAt), Icons.calendar_today),
            const SizedBox(height: 12),
            _buildInfoRow(S.of(context).lastLogin, _formatDate(user.lastLogin), Icons.access_time),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.primaryLight,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
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