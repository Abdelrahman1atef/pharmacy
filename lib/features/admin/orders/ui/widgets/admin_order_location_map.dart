import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmacy/core/models/order/admin/admin_order_model.dart';
import 'package:pharmacy/generated/l10n.dart';

class AdminOrderLocationMap extends StatefulWidget {
  final AdminOrderModel order;

  const AdminOrderLocationMap({
    super.key,
    required this.order,
  });

  @override
  State<AdminOrderLocationMap> createState() => _AdminOrderLocationMapState();
}

class _AdminOrderLocationMapState extends State<AdminOrderLocationMap> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  void _createMarkers() {
    if (widget.order.latitude != null && widget.order.longitude != null) {
      final position = LatLng(widget.order.latitude!, widget.order.longitude!);
      
      _markers.add(
        Marker(
          markerId: const MarkerId('order_location'),
          position: position,
          infoWindow: InfoWindow(
            title: '${widget.order.firstName} ${widget.order.lastName}',
            snippet: widget.order.addressStreet ?? 'Delivery Address',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if we have valid coordinates
    if (widget.order.latitude == null || widget.order.longitude == null) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_off,
                size: 48,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 8),
              Text(
                'Location not available',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final initialPosition = LatLng(
      widget.order.latitude!,
      widget.order.longitude!,
    );

    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: initialPosition,
            zoom: 15.0,
          ),
          markers: _markers,
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          compassEnabled: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
} 