
import 'package:order_application/Data/Providers/network/api_provider.dart';
import 'package:order_application/Data/Providers/network/api_request_representable.dart';

import '../api_endpoint.dart';

enum RateAction {
  rate,
}

class RateAPI implements APIRequestRepresentable {
  final RateAction action;
  final String token;
  final String rateableType;
  final int rateableId;
  final int rate;

  RateAPI._({
    required this.action,
    required this.token,
    required this.rateableType,
    required this.rateableId,    
    required this.rate,
  });

  RateAPI.rate(String token, String rateableType, int rateableId, int rate)
      : this._(action: RateAction.rate, token: token, rateableType: rateableType,rateableId: rateableId, rate: rate);

  @override
  String get endpoint => APIEndpoint.API;

  @override
  String get path => "/user/rate";

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  Map<String, String> get headers => {
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
  };

  @override
  Map<String, String> get query {
    final Map<String, String> queryParams = {};
    return queryParams;
  }

  @override
  dynamic get body {
    return {
      'rateable_id': rateableId,
      'rateable_type': rateableType,
      'rate': rate
    };
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}