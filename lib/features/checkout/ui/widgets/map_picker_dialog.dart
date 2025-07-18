import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPickerDialog extends StatefulWidget {
  final LatLng initialPosition;
  const MapPickerDialog({super.key, required this.initialPosition});

  static Future<LatLng?> show(BuildContext context, {required LatLng initialPosition}) async {
    return showDialog<LatLng>(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          width: 400,
          height: 700,
          child: MapPickerDialog(initialPosition: initialPosition),
        ),
      ),
    );
  }

  @override
  State<MapPickerDialog> createState() => _MapPickerDialogState();
}

class _MapPickerDialogState extends State<MapPickerDialog> {
  late GoogleMapController _mapController;
  late LatLng _selectedPosition;

  @override
  void initState() {
    super.initState();
    _selectedPosition = widget.initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _selectedPosition,
              zoom: 15,
            ),
            onMapCreated: (controller) => _mapController = controller,
            myLocationEnabled: true,
            onTap: (position) {
              setState(() {
                _selectedPosition = position;
              });
            },
            markers: {
              Marker(
                markerId: const MarkerId('selected'),
                position: _selectedPosition,
                draggable: true,
                onDragEnd: (pos) {
                  setState(() {
                    _selectedPosition = pos;
                  });
                },
              ),
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('إلغاء'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(_selectedPosition),
                child: const Text('تأكيد الموقع'),
              ),
            ],
          ),
        ),
      ],
    );
  }
} 