import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteInfo {
  final LatLng origin;
  final LatLng destination;
  final List<LatLng> polylinePoints;
  final double distance; // in meters
  final int duration; // in seconds
  final RouteType routeType;

  RouteInfo({
    required this.origin,
    required this.destination,
    required this.polylinePoints,
    required this.distance,
    required this.duration,
    required this.routeType,
  });

  String get formattedDistance {
    if (distance < 1000) {
      return '${distance.toStringAsFixed(0)} m';
    } else {
      return '${(distance / 1000).toStringAsFixed(1)} km';
    }
  }

  String get formattedDuration {
    if (duration < 60) {
      return '${duration}s';
    } else if (duration < 3600) {
      return '${(duration / 60).toStringAsFixed(0)} min';
    } else {
      final hours = (duration / 3600).floor();
      final minutes = ((duration % 3600) / 60).floor();
      return '${hours}h ${minutes}m';
    }
  }

  Set<Polyline> get polylines {
    return {
      Polyline(
        polylineId: const PolylineId('route'),
        points: polylinePoints,
        color: Colors.blue,
        width: 5,
      ),
    };
  }

  Set<Marker> get markers {
    return {
      Marker(
        markerId: const MarkerId('origin'),
        position: origin,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(title: 'Origin'),
      ),
      Marker(
        markerId: const MarkerId('destination'),
        position: destination,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(title: 'Destination'),
      ),
    };
  }
}

enum RouteType {
  driving,
  walking,
  bicycling,
  transit,
} 