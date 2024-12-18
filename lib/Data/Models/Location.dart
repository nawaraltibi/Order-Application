import 'dart:math';

class Location {
  final String name;
  final double latitude;
  final double longitude;

  Location({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }

  double distanceTo(Location other) {
    const double earthRadius = 6371.0;
    final double dLat = _degreesToRadians(other.latitude - latitude);
    final double dLon = _degreesToRadians(other.longitude - longitude);

    final double a =
        (sin(dLat / 2) * sin(dLat / 2)) +
            cos(_degreesToRadians(latitude)) *
                cos(_degreesToRadians(other.latitude)) *
                (sin(dLon / 2) * sin(dLon / 2));

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (3.141592653589793 / 180.0);
  }

  @override
  String toString() {
    return 'Location(latitude: $latitude, longitude: $longitude)';
  }
}
