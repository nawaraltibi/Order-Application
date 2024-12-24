import 'package:order_application/Data/Models/User.dart';
import 'package:order_application/Data/providers/network/api_endpoint.dart';
import 'package:order_application/Data/providers/network/api_provider.dart';
import 'package:order_application/Data/providers/network/api_request_representable.dart';

enum AuthAction {
  register,
  resendVerificationCode,
  verify,
  logout
}

class AuthAPI implements APIRequestRepresentable {
  final AuthAction action;
  final User? user;
  final String? token;

  AuthAPI._({
    required this.action,
    this.user,
    this.token,
  });

  // Constructor for the registration action
  AuthAPI.register(User user)
      : this._(action: AuthAction.register, user: user);

  // Constructor for the resend verification code action
  AuthAPI.resendVerificationCode(User user)
      : this._(action: AuthAction.resendVerificationCode, user: user);

  // Constructor for the verify action
  AuthAPI.verify(User user)
      : this._(action: AuthAction.verify, user: user);

  // Constructor for the logout action
  AuthAPI.logout(String token) : this._(action: AuthAction.logout,token: token);

  @override
  String get endpoint => APIEndpoint.API;

  @override
  String get path {
    switch (action) {
      case AuthAction.register:
      case AuthAction.resendVerificationCode:
        return "/otp-request";
      case AuthAction.verify:
        return "/otp-check";
      case AuthAction.logout:
        return "/user/logout";
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
        return {'phone': user?.phone};
      case AuthAction.verify:
        return {'phone': user?.phone, 'otp': user?.otp};
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