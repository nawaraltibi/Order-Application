import 'package:order_application/Data/providers/network/api_endpoint.dart';
import 'package:order_application/Data/providers/network/api_provider.dart';
import 'package:order_application/Data/providers/network/api_request_representable.dart';

enum UserAction {
  getAuthenticatedUser,
}

class UserAPI implements APIRequestRepresentable {
  final UserAction action;
  final String token;

  UserAPI._({
    required this.action,
    required this.token,
  });

  UserAPI.getAuthenticatedUser(
    String token,
  ) : this._(
          action: UserAction.getAuthenticatedUser,
          token: token,
        );

  @override
  String get endpoint => APIEndpoint.API;

  @override
  String get path {
    switch (action) {
      case UserAction.getAuthenticatedUser:
        return "/user";
    }
  }

  @override
  HTTPMethod get method {
    switch (action) {
      case UserAction.getAuthenticatedUser:
        return HTTPMethod.get;
    }
  }

  @override
  Map<String, String> get headers {
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  @override
  Map<String, String> get query => {};

  @override
  dynamic get body {
    switch (action) {
      case UserAction.getAuthenticatedUser:
        return null;
    }
  }

  @override
  Future<dynamic> request() async {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}
