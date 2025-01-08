import 'Location.dart';

class Driver {
  int? id;
  String? phone;
  String? otp;
  String? name;
  String? firstName;
  String? lastName;
  Location? location;

  Driver.empty();

  Driver({
    this.id,
    this.phone,
    this.otp,
    this.firstName,
    this.lastName,
    this.location,
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
    };
  }

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: (json['id']??json['user_id'])  as int,
      phone: json['phone'] as String,
      otp: json['otp'] as String?,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
    );
  }
}