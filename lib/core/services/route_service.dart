import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../models/route_info.dart';

class RouteService {
  static final RouteService _instance = RouteService._internal();
  factory RouteService() => _instance;
  RouteService._internal();

  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/directions/json';
  static const String _apiKey = 'YOUR_GOOGLE_MAPS_API_KEY'; // Replace with your API key

  Future<RouteInfo?> getRoute({
    required LatLng origin,
    required LatLng destination,
    RouteType routeType = RouteType.driving,
  }) async {
    try {
      final String mode = _getRouteMode(routeType);
      final url = Uri.parse(
        '$_baseUrl?origin=${origin.latitude},${origin.longitude}'
        '&destination=${destination.latitude},${destination.longitude}'
        '&mode=$mode'
        '&key=$_apiKey',
      );

      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['status'] == 'OK' && data['routes'].isNotEmpty) {
          final route = data['routes'][0];
          final leg = route['legs'][0];
          
          final distance = leg['distance']['value'].toDouble();
          final duration = leg['duration']['value'].toInt();
          
          final polylinePoints = _decodePolyline(route['overview_polyline']['points']);
          
          return RouteInfo(
            origin: origin,
            destination: destination,
            polylinePoints: polylinePoints,
            distance: distance,
            duration: duration,
            routeType: routeType,
          );
        }
      }
      
      return null;
    } catch (e) {
      debugPrint('Error getting route: $e');
      return null;
    }
  }

  String _getRouteMode(RouteType routeType) {
    switch (routeType) {
      case RouteType.driving:
        return 'driving';
      case RouteType.walking:
        return 'walking';
      case RouteType.bicycling:
        return 'bicycling';
      case RouteType.transit:
        return 'transit';
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      final p = LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      poly.add(p);
    }
    return poly;
  }

  // Mock route for testing (when API key is not available)
  RouteInfo? getMockRoute({
    required LatLng origin,
    required LatLng destination,
    RouteType routeType = RouteType.driving,
  }) {
    // Create a simple straight line route
    final polylinePoints = [origin, destination];
    final distance = _calculateDistance(origin, destination);
    final duration = (distance / 1000 * 60).round(); // Rough estimate: 1km = 1 minute
    
    return RouteInfo(
      origin: origin,
      destination: destination,
      polylinePoints: polylinePoints,
      distance: distance,
      duration: duration,
      routeType: routeType,
    );
  }

  double _calculateDistance(LatLng start, LatLng end) {
    const double earthRadius = 6371000; // Earth's radius in meters
    
    final double lat1 = start.latitude * (pi / 180);
    final double lat2 = end.latitude * (pi / 180);
    final double deltaLat = (end.latitude - start.latitude) * (pi / 180);
    final double deltaLng = (end.longitude - start.longitude) * (pi / 180);

    final double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
        cos(lat1) * cos(lat2) * sin(deltaLng / 2) * sin(deltaLng / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }
} 