import 'package:order_application/Data/Models/Driver.dart';
import 'package:order_application/Data/providers/network/api_endpoint.dart';
import 'package:order_application/Data/providers/network/api_provider.dart';
import 'package:order_application/Data/providers/network/api_request_representable.dart';
import 'auth_api.dart';

class DriverAuthAPI implements APIRequestRepresentable {
  final AuthAction action;
  final Driver? driver;
  final String? token;

  DriverAuthAPI._({
    required this.action,
    this.driver,
    this.token,
  });

  // Constructor for the registration action
  DriverAuthAPI.register(Driver driver)
      : this._(action: AuthAction.register, driver: driver);

  // Constructor for the resend verification code action
  DriverAuthAPI.resendVerificationCode(Driver driver)
      : this._(action: AuthAction.resendVerificationCode, driver: driver);

  // Constructor for the verify action
  DriverAuthAPI.verify(Driver driver)
      : this._(action: AuthAction.verify, driver: driver);

  // Constructor for the logout action
  DriverAuthAPI.logout(String token) : this._(action: AuthAction.logout, token: token);

  @override
  String get endpoint => APIEndpoint.API;

  @override
  String get path {
    switch (action) {
      case AuthAction.register:
      case AuthAction.resendVerificationCode:
        return "/driver/otp-request";
      case AuthAction.verify:
        return "/driver/otp-check";
      case AuthAction.logout:
        return "/driver/logout";
    }
  }

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  Map<String, String> get headers {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    if (action == AuthAction.logout && token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  @override
  Map<String, String> get query => {};

  @override
  dynamic get body {
    switch (action) {
      case AuthAction.register:
      case AuthAction.resendVerificationCode:
        return {'phone': driver?.phone};
      case AuthAction.verify:
        return {'phone': driver?.phone, 'otp': driver?.otp};
      case AuthAction.logout:
        return null;
    }
  }

  Future<dynamic> request() async {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}