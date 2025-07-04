import 'package:flutter/material.dart';
import '../../logic/location/saved_location.dart';
import '../../logic/location/location_storage.dart';

class LocationBottomSheet extends StatefulWidget {
  final Function(SavedLocation) onLocationSelected;
  final VoidCallback onAddNewLocation;
  const LocationBottomSheet({super.key, required this.onLocationSelected, required this.onAddNewLocation});

  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  List<SavedLocation> _locations = [];
  String? _selectedId;

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  void _loadLocations() {
    setState(() {
      _locations = LocationStorage.loadLocations();
      if (_locations.isNotEmpty) {
        _selectedId = _locations.firstWhere((loc) => loc.isDefault, orElse: () => _locations.first).id;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('اختر عنوان التوصيل', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                IconButton(
                  icon: const Icon(Icons.add_location_alt_outlined),
                  onPressed: widget.onAddNewLocation,
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (_locations.isEmpty)
              const Text('لا يوجد عناوين محفوظة'),
            ..._locations.map((loc) => Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                onTap: () {
                  widget.onLocationSelected(loc);
                  Navigator.of(context).pop();
                },
                title: Row(
                  children: [
                    Text(loc.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    if (loc.isDefault)
                      const Padding(
                        padding: EdgeInsets.only(right: 4.0),
                        child: Icon(Icons.star, color: Colors.amber, size: 18),
                      ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(loc.street),
                    if (loc.specialPoint.isNotEmpty)
                      Text('علامة مميزة: ${loc.specialPoint}', style: const TextStyle(fontSize: 12)),
                  ],
                ),
                isThreeLine: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            )),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: widget.onAddNewLocation,
              icon: const Icon(Icons.add),
              label: const Text('إضافة عنوان جديد'),
            ),
          ],
        ),
      ),
    );
  }
} 