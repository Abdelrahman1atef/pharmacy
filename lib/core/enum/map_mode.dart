import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

enum MapMode {
  view,
  navigation,
  route,
  location,
}

enum RouteType {
  driving,
  walking,
  bicycling,
  transit,
}

extension MapModeLocalization on MapMode {
  String getLocalizedDisplayName(S s) {
    switch (this) {
      case MapMode.view:
        return 'View';
      case MapMode.navigation:
        return s.startNavigation;
      case MapMode.route:
        return s.routeToDestination;
      case MapMode.location:
        return s.myLocation;
    }
  }

  IconData getIcon() {
    switch (this) {
      case MapMode.view:
        return Icons.map;
      case MapMode.navigation:
        return Icons.navigation;
      case MapMode.route:
        return Icons.route;
      case MapMode.location:
        return Icons.my_location;
    }
  }
}

extension RouteTypeLocalization on RouteType {
  String getLocalizedDisplayName(S s) {
    switch (this) {
      case RouteType.driving:
        return 'Driving';
      case RouteType.walking:
        return 'Walking';
      case RouteType.bicycling:
        return 'Bicycling';
      case RouteType.transit:
        return 'Transit';
    }
  }

  IconData getIcon() {
    switch (this) {
      case RouteType.driving:
        return Icons.directions_car;
      case RouteType.walking:
        return Icons.directions_walk;
      case RouteType.bicycling:
        return Icons.directions_bike;
      case RouteType.transit:
        return Icons.directions_bus;
    }
  }
} 