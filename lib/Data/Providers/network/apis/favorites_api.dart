import 'package:order_application/Data/Providers/network/api_provider.dart';
import 'package:order_application/Data/Providers/network/api_request_representable.dart';

import '../api_endpoint.dart';

enum FavoritesAction {
  addRemove,
  showFavorites,
}

class FavoritesAPI implements APIRequestRepresentable {
  final FavoritesAction action;
  final String token;
  final int? productId;
  final int? page;

  FavoritesAPI._({
    required this.action,
    required this.token,
    this.productId,
    this.page,
  });

  // Constructor for show favorites with page parameter
  FavoritesAPI.showFavorites({
    required String token,
    required int page,
  }) : this._(
          action: FavoritesAction.showFavorites,
          token: token,
          page: page,
        );

  // Constructor for add or remove form favorites
  FavoritesAPI.addRemove({
    required String token,
    required int productId,
  }) : this._(
          action: FavoritesAction.addRemove,
          token: token,
          productId: productId,
        );

  @override
  String get endpoint => APIEndpoint.API;

  @override
  String get path => "/user/favorites";

  @override
  HTTPMethod get method {
    switch (action) {
      case FavoritesAction.addRemove:
        return HTTPMethod.post;
      case FavoritesAction.showFavorites:
        return HTTPMethod.get;
    }
  }

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
  dynamic get body {
    switch (action) {
      case FavoritesAction.addRemove:
        return {
          'product_id': productId
        };
      case FavoritesAction.showFavorites:
        return null;
    }
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}