import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  StreamSubscription<Position>? _locationSubscription;
  LatLng? _currentLocation;
  bool _isLocationEnabled = false;

  LatLng? get currentLocation => _currentLocation;
  bool get isLocationEnabled => _isLocationEnabled;

  Future<bool> checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    _isLocationEnabled = true;
    return true;
  }

  Future<LatLng?> getCurrentLocation() async {
    try {
      if (!await checkLocationPermission()) {
        return null;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _currentLocation = LatLng(position.latitude, position.longitude);
      return _currentLocation;
    } catch (e) {
      debugPrint('Error getting current location: $e');
      return null;
    }
  }

  void startLocationUpdates() {
    if (!_isLocationEnabled) return;

    _locationSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Update every 10 meters
      ),
    ).listen((Position position) {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void stopLocationUpdates() {
    _locationSubscription?.cancel();
  }

  Future<double> calculateDistance(LatLng destination) async {
    if (_currentLocation == null) return 0.0;

    return Geolocator.distanceBetween(
      _currentLocation!.latitude,
      _currentLocation!.longitude,
      destination.latitude,
      destination.longitude,
    );
  }

  void dispose() {
    stopLocationUpdates();
  }
} 