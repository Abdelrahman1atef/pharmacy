import 'package:flutter/material.dart';
import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/core/services/share_service.dart';
import 'package:pharmacy/generated/l10n.dart';

class ShareOptionsDialog extends StatelessWidget {
  final Results product;

  const ShareOptionsDialog({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Share Product'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildShareOption(
            context,
            icon: Icons.share,
            title: 'Share with Details',
            subtitle: 'Share product with full details',
            onTap: () {
              Navigator.pop(context);
              ShareService.shareProductWithContext(
                product: product,
                context: context,
              );
            },
          ),
          const SizedBox(height: 8),
          _buildShareOption(
            context,
            icon: Icons.link,
            title: 'Share Link Only',
            subtitle: 'Share just the product URL',
            onTap: () {
              Navigator.pop(context);
              ShareService.shareProductUrl(
                product: product,
                context: context,
              );
            },
          ),
          const SizedBox(height: 8),
          _buildShareOption(
            context,
            icon: Icons.local_offer,
            title: 'Share as Promotion',
            subtitle: 'Share with promotional message',
            onTap: () {
              Navigator.pop(context);
              ShareService.shareProductPromotional(
                product: product,
                context: context,
                discountInfo: 'Limited time offer!',
              );
            },
          ),
          const SizedBox(height: 8),
          _buildShareOption(
            context,
            icon: Icons.text_snippet,
            title: 'Simple Share',
            subtitle: 'Share product name and link only',
            onTap: () {
              Navigator.pop(context);
              ShareService.shareProductSimple(
                product: product,
                context: context,
              );
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(S.of(context).cancel),
        ),
      ],
    );
  }

  Widget _buildShareOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
} 