import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:order_application/App/Const/Host.dart';

class Location {
  int? id;
  final String name;
  final double latitude;
  final double longitude;
  String? region;
  String? street;

  Location({
    this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.region,
    this.street,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'region': region,
      'street': street,
    };
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] as int,
      name: json['name'] as String,
      latitude: json['latitude'] is String
          ? double.parse(json['latitude'] as String)
          : json['latitude'] as double,
      longitude: json['longitude'] is String
          ? double.parse(json['longitude'] as String)
          : json['longitude'] as double,
      region: json['municipality'] != null ? json['municipality'] as String :null,
      street: json['road'] != null ? json['road'] as String :null,
    );
  }

  static List<Location> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => Location.fromJson(json)).toList();
  }

  Future<void> fetchLocationDetails() async {
    final url =
        'https://us1.locationiq.com/v1/reverse?key=$apiKey&lat=$latitude&lon=$longitude&format=json';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final address = data['address'] as Map<String, dynamic>;

        // Extracting region and street from the response
        region = address['city'];
        street = address['road'];
      } else {
        print('Failed to fetch location details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while fetching location details: $e');
    }
  }

  @override
  String toString() {
    return 'Location(latitude: $latitude, longitude: $longitude, region: $region, street: $street)';
  }
}