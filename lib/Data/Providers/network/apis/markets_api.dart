import 'package:order_application/Data/Providers/network/api_provider.dart';
import 'package:order_application/Data/Providers/network/api_request_representable.dart';
import '../api_endpoint.dart';

enum MarketsAction {
  getProducts,
}

class MarketsAPI implements APIRequestRepresentable {
  final MarketsAction action;
  final String token;
  final int id;
  final int page;

  MarketsAPI._({
    required this.action,
    required this.token,
    required this.id,
    required this.page,
  });

  MarketsAPI.getProducts(String token, int id, int page)
      : this._(action: MarketsAction.getProducts, id: id, token: token, page: page);

  @override
  String get endpoint => APIEndpoint.API;

  @override
  String get path => "/user/markets/$id/products";

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Map<String, String> get headers => {
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
  };

  @override
  Map<String, String> get query {
    final Map<String, String> queryParams = {};
    queryParams['page'] = page.toString();
    return queryParams;
  }

  @override
  dynamic get body => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}