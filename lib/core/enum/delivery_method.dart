import 'package:json_annotation/json_annotation.dart';
import 'package:pharmacy/generated/l10n.dart';

enum DeliveryMethod {
  @JsonValue('home_delivery')
  homeDelivery,
  
  @JsonValue('pharmacy_pickup')
  pharmacyPickup,
}

extension DeliveryMethodExtension on DeliveryMethod {
  String get displayName {
    switch (this) {
      case DeliveryMethod.homeDelivery:
        return 'home_delivery';
      case DeliveryMethod.pharmacyPickup:
        return 'pharmacy_pickup';
    }
  }
  
  String getLocalizedDisplayName(S s) {
    switch (this) {
      case DeliveryMethod.homeDelivery:
        return s.homeDelivery;
      case DeliveryMethod.pharmacyPickup:
        return s.pharmacyPickup;
    }
  }
  
  bool get isHomeDelivery => this == DeliveryMethod.homeDelivery;
  bool get isPharmacyPickup => this == DeliveryMethod.pharmacyPickup;
} 