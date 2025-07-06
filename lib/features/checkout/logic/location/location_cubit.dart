import 'package:flutter_bloc/flutter_bloc.dart';
import 'saved_location.dart';
import 'location_storage.dart';

class LocationCubit extends Cubit<SavedLocation?> {
  LocationCubit() : super(null) {
    _loadDefaultLocation();
  }

  void selectLocation(SavedLocation location) {
    emit(location);
  }

  void _loadDefaultLocation() {
    try {
      final locations = LocationStorage.loadLocations();
      if (locations.isEmpty) {
        // No saved locations, keep state as null
        return;
      }
      
      final defaultLocation = locations.where((location) => location.isDefault).firstOrNull;
      if (defaultLocation != null) {
        emit(defaultLocation);
      } else {
        // If no default location is set, use the first location as default
        emit(locations.first);
      }
    } catch (e) {
      // Handle any errors in loading locations
      print('Error loading default location: $e');
    }
  }

  void loadDefaultLocation() {
    _loadDefaultLocation();
  }

  void refreshDefaultLocation() {
    _loadDefaultLocation();
  }
} 