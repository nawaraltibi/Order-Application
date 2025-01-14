import 'package:order_application/Data/providers/network/api_endpoint.dart';
import 'package:order_application/Data/providers/network/api_provider.dart';
import 'package:order_application/Data/providers/network/api_request_representable.dart';

enum ProductsAction {
  bestSelling,
  topRated,
  productsForYou,
}

class ProductsAPI implements APIRequestRepresentable {
  final ProductsAction action;
  final String token;

  ProductsAPI._({
    required this.action,
    required this.token,
  });

  // Constructor for Best Selling Products action
  ProductsAPI.bestSelling(String token)
      : this._(action: ProductsAction.bestSelling, token: token);

  // Constructor for Top Rated Products action
  ProductsAPI.topRated(String token)
      : this._(action: ProductsAction.topRated, token: token);

  // Constructor for "Products For You" action
  ProductsAPI.forYou(String token)
      : this._(action: ProductsAction.productsForYou, token: token);

  @override
  String get endpoint => APIEndpoint.API;

  @override
  String get path {
    switch (action) {
      case ProductsAction.bestSelling:
        return "/user/products/best-selling";
      case ProductsAction.topRated:
        return "/user/products/top-rated";
      case ProductsAction.productsForYou:
        return "/user/products";
    }
  }

  @override
  HTTPMethod get method {
    return HTTPMethod.get; // Both requests are GET
  }

  @override
  Map<String, String> get headers {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  @override
  Map<String, String> get query => {}; // No query parameters required

  @override
  dynamic get body => null; // No body required

  Future<dynamic> request() async {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}
