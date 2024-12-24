import 'package:order_application/Data/Models/Location.dart';
import 'package:order_application/Data/providers/network/api_endpoint.dart';
import 'package:order_application/Data/providers/network/api_provider.dart';
import 'package:order_application/Data/providers/network/api_request_representable.dart';

enum AddressesAction {
  getAllAddresses,
  createAnAddress,
  getAnAddress,
  deleteAnAddress,
}

class AddressAPI implements APIRequestRepresentable {
  final AddressesAction action;
  final String token;
  final Location? location;
  final int? id;

  AddressAPI._({
    required this.action,
    required this.token,
    this.location,
    this.id,
  });

  // Constructor for get All Addresses action
  AddressAPI.getAllAddresses(String token) : this._(action: AddressesAction.getAllAddresses, token: token);

  // Constructor for create An Address action
  AddressAPI.createAnAddress(String token, Location location)
      : this._(action: AddressesAction.createAnAddress, token: token, location: location);

  // Constructor for get An Address action
  AddressAPI.getAnAddress(String token, int id) : this._(action: AddressesAction.getAnAddress, token: token, id: id);

  // Constructor for delete An Address action
  AddressAPI.deleteAnAddress(String token, int id) : this._(action: AddressesAction.deleteAnAddress, token: token, id: id);

  @override
  String get endpoint => APIEndpoint.API;

  @override
  String get path {
    switch (action) {
      case AddressesAction.getAllAddresses:
      case AddressesAction.createAnAddress:
        return "/user/addresses";
      case AddressesAction.getAnAddress:
        return "/user/addresses/$id";
      case AddressesAction.deleteAnAddress:
        return "/user/addresses/$id";
    }
  }

  @override
  HTTPMethod get method {
    switch (action) {
      case AddressesAction.getAllAddresses:
        return HTTPMethod.get;
      case AddressesAction.createAnAddress:
        return HTTPMethod.post;
      case AddressesAction.getAnAddress:
        return HTTPMethod.get;
      case AddressesAction.deleteAnAddress:
        return HTTPMethod.delete;
    }
  }

  @override
  Map<String, String> get headers {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return headers;
  }

  @override
  Map<String, String> get query => {};

  @override
  dynamic get body {
    switch (action) {
      case AddressesAction.createAnAddress:
        return {
          'name': location?.name,
          'location_longitude': location?.longitude,
          'location_latitude': location?.latitude,
        };
      case AddressesAction.getAllAddresses:
      case AddressesAction.getAnAddress:
      case AddressesAction.deleteAnAddress:
        return null;
    }
  }

  Future<dynamic> request() async {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}
