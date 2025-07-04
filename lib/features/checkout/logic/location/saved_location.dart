import 'dart:convert';

class SavedLocation {
  final String id;
  final String name;
  final String street;
  final String specialPoint;
  final double latitude;
  final double longitude;
  final bool isDefault;

  SavedLocation({
    required this.id,
    required this.name,
    required this.street,
    required this.specialPoint,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'street': street,
    'specialPoint': specialPoint,
    'latitude': latitude,
    'longitude': longitude,
    'isDefault': isDefault,
  };

  factory SavedLocation.fromJson(Map<String, dynamic> json) => SavedLocation(
    id: json['id'] as String,
    name: json['name'] as String,
    street: json['street'] as String,
    specialPoint: json['specialPoint'] as String,
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    isDefault: json['isDefault'] as bool,
  );

  static List<SavedLocation> decodeList(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => SavedLocation.fromJson(e)).toList();
  }

  static String encodeList(List<SavedLocation> locations) {
    return json.encode(locations.map((e) => e.toJson()).toList());
  }
} 