import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pharmacy/generated/l10n.dart';

class LocationPermissionWidget extends StatefulWidget {
  final VoidCallback? onPermissionGranted;
  final Widget child;

  const LocationPermissionWidget({
    super.key,
    this.onPermissionGranted,
    required this.child,
  });

  @override
  State<LocationPermissionWidget> createState() => _LocationPermissionWidgetState();
}

class _LocationPermissionWidgetState extends State<LocationPermissionWidget> {
  bool _isCheckingPermission = false;
  bool _hasPermission = false;
  String? _permissionMessage;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    setState(() {
      _isCheckingPermission = true;
    });

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _permissionMessage = 'Location services are disabled. Please enable location services in your device settings.';
          _isCheckingPermission = false;
        });
        return;
      }

      // Check current permission status
      LocationPermission permission = await Geolocator.checkPermission();
      
      if (permission == LocationPermission.denied) {
        // Request permission
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _permissionMessage = 'Location permission is permanently denied. Please enable it in app settings.';
          _isCheckingPermission = false;
        });
        return;
      }

      if (permission == LocationPermission.denied) {
        setState(() {
          _permissionMessage = 'Location permission is required for map functionality.';
          _isCheckingPermission = false;
        });
        return;
      }

      // Permission granted
      setState(() {
        _hasPermission = true;
        _isCheckingPermission = false;
      });

      widget.onPermissionGranted?.call();
    } catch (e) {
      setState(() {
        _permissionMessage = 'Error checking location permission: $e';
        _isCheckingPermission = false;
      });
    }
  }

  Future<void> _openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    if (_isCheckingPermission) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Checking location permission...'),
            ],
          ),
        ),
      );
    }

    if (_hasPermission) {
      return widget.child;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_off,
            size: 48,
            color: Colors.orange[600],
          ),
          const SizedBox(height: 16),
          Text(
            'Location Permission Required',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _permissionMessage ?? 'Location permission is needed to show your current location on the map.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.orange[700],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _checkPermission,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[600],
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: _openAppSettings,
                icon: const Icon(Icons.settings),
                label: const Text('Settings'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[800],
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 