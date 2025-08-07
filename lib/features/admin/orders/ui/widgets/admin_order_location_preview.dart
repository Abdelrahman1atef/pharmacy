import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmacy/core/models/order/admin/admin_order_model.dart';

class AdminOrderLocationPreview extends StatefulWidget {
  final AdminOrderModel order;

  const AdminOrderLocationPreview({
    super.key,
    required this.order,
  });

  @override
  State<AdminOrderLocationPreview> createState() => _AdminOrderLocationPreviewState();
}

class _AdminOrderLocationPreviewState extends State<AdminOrderLocationPreview> {
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
          markerId: const MarkerId('order_location_preview'),
          position: position,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if we have valid coordinates
    if (widget.order.latitude == null || widget.order.longitude == null) {
      return Container(
        width: 60,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.location_off,
          size: 20,
          color: Colors.grey,
        ),
      );
    }

    final initialPosition = LatLng(
      widget.order.latitude!,
      widget.order.longitude!,
    );

    return Container(
      width: 60,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: initialPosition,
            zoom: 13.0,
          ),
          markers: _markers,
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          compassEnabled: false,
          liteModeEnabled: true, // Use lite mode for better performance
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