import 'dart:convert';
import 'dart:io';
import 'package:order_application/Data/Models/CreditCard.dart';
import 'package:order_application/Data/Models/Location.dart';
import 'package:order_application/Data/Models/Order.dart';

class User {
  int? id;
  String? phone;
  String? otp;
  String? name;
  String? firstName;
  String? lastName;
  File? image;
  String? imageName;
  List<Location>? locations;
  List<CreditCard>? cards;

  User.empty();

  User({
    this.id,
    this.phone,
    this.otp,
    this.firstName,
    this.lastName,
    this.image,
    this.imageName,
    this.locations,
    this.cards,
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
      'first_name': firstName,
      'last_name': lastName,
      'profile_picture': base64Encode(image!.readAsBytesSync()),
      'locations': locations?.map((location) => location.toJson()).toList(),
      'cards': cards?.map((card) => card.toJson()).toList(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: (json['id']??json['user_id'])  as int,
      phone: json['phone'] as String,
      otp: json['otp'] as String?,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      imageName: json['profile_picture'] as String,
      locations: json['locations'] != null
          ? (json['locations'] as List<dynamic>)
          .map((locationJson) => Location.fromJson(locationJson))
          .toList()
          : null,
      cards: json['cards'] != null
          ? (json['cards'] as List<dynamic>)
          .map((cardJson) => CreditCard.fromJson(cardJson))
          .toList()
          : null,
    );
  }
}