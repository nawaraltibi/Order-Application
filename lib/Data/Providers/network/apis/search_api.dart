
import 'package:order_application/Data/Providers/network/api_provider.dart';
import 'package:order_application/Data/Providers/network/api_request_representable.dart';

import '../api_endpoint.dart';

enum TagAction {
  search,
}

class SearchAPI implements APIRequestRepresentable {
  final TagAction action;
  final String token;
  final String searchType;
  final String word;
  final int page;

  SearchAPI._({
    required this.action,
    required this.token,
    required this.searchType,
    required this.word,
    required this.page,
  });

  // Constructor for search with page parameter
  SearchAPI.search({
    required String token,
    required String searchType,
    required String word,
    required int page,
  }) : this._(
    action: TagAction.search,
    token: token,
    searchType: searchType,
    word: word,
    page: page,
  );

  @override
  String get endpoint => APIEndpoint.API;

  @override
  String get path => "/user/search";

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
    queryParams['search_type'] = searchType.toString();
    queryParams['query'] = word.toString();
    queryParams['page'] = page.toString();
    return queryParams;
  }

  @override
  dynamic get body {
    return null;
  }

  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}