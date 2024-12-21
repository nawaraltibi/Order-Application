import 'dart:convert';
import 'dart:io';
import 'package:order_application/Data/Models/Location.dart';

class User {
  String? phone;
  String? otp;
  String? name;
  String? firstName;
  String? lastName;
  File? image;
  List<Location>? locations;

  User.empty();

  User({
    required this.phone,
    required this.otp,
    required this.firstName,
    required this.lastName,
    required this.image,
    this.locations = const [],
  }){
    name = setName();
  }

  String setName(){
    return "$firstName $lastName";
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'otp': otp,
      'firstName': firstName,
      'lastName': lastName,
      'image': base64Encode(image!.readAsBytesSync()),
      'locations': locations!.map((location) => location.toJson()).toList(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      phone: json['phone'] as String,
      otp: json['otp'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      image: File.fromRawPath(base64Decode(json['image'] as String)),
      locations: (json['locations'] as List<dynamic>)
          .map((locationJson) => Location.fromJson(locationJson))
          .toList(),
    );
  }
}