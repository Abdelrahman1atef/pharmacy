import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pharmacy/core/models/order/admin/admin_order_model.dart';
import 'package:pharmacy/generated/l10n.dart';

class NavigationActions extends StatelessWidget {
  final AdminOrderModel order;

  const NavigationActions({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    if (!order.hasLocation) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).getDirections,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildNavigationButton(
                  context,
                  'Google Maps',
                  Icons.map,
                  Colors.red,
                  () => _openGoogleMaps(context),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildNavigationButton(
                  context,
                  'Apple Maps',
                  Icons.navigation,
                  Colors.blue,
                  () => _openAppleMaps(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Future<void> _openGoogleMaps(BuildContext context) async {
    final lat = order.latitude!;
    final lng = order.longitude!;
    final url = 'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng';
    
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open Google Maps')),
        );
      }
    }
  }

  Future<void> _openAppleMaps(BuildContext context) async {
    final lat = order.latitude!;
    final lng = order.longitude!;
    final url = 'https://maps.apple.com/?daddr=$lat,$lng';
    
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open Apple Maps')),
        );
      }
    }
  }
} 