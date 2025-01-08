import 'package:order_application/Data/Models/Order.dart';
import 'package:order_application/Data/providers/network/api_endpoint.dart';
import 'package:order_application/Data/providers/network/api_provider.dart';
import 'package:order_application/Data/providers/network/api_request_representable.dart';

enum OrdersAction {
  getAllOrders,
  createAnOrder,
  getAnOrder,
  deleteAnOrder,
  editAnOrder,
}

class OrdersAPI implements APIRequestRepresentable {
  final OrdersAction action;
  final String token;
  final Order? order;
  final int? id;

  OrdersAPI._({
    required this.action,
    required this.token,
    this.order,
    this.id,
  });

  // Constructor for get All Orders action
  OrdersAPI.getAllOrders(String token)
      : this._(action: OrdersAction.getAllOrders, token: token);

  // Constructor for create An Order action
  OrdersAPI.createAnOrder(String token, Order order)
      : this._(action: OrdersAction.createAnOrder, token: token, order: order);

  // Constructor for get An Order action
  OrdersAPI.getAnOrder(String token, int id)
      : this._(action: OrdersAction.getAnOrder, token: token, id: id);

  // Constructor for delete An Order action
  OrdersAPI.deleteAnOrder(String token, int id)
      : this._(action: OrdersAction.deleteAnOrder, token: token, id: id);

  // Constructor for edit An Order action
  OrdersAPI.editAnOrder(String token, int id, Order order)
      : this._(action: OrdersAction.editAnOrder, token: token, id: id,order: order);

  @override
  String get endpoint => APIEndpoint.API;

  @override
  String get path {
    switch (action) {
      case OrdersAction.getAllOrders:
      case OrdersAction.createAnOrder:
      return "/user/orders";
      case OrdersAction.getAnOrder:
      case OrdersAction.deleteAnOrder:
      case OrdersAction.editAnOrder:
        return "/user/orders/$id";
    }
  }

  @override
  HTTPMethod get method {
    switch (action) {
      case OrdersAction.getAllOrders:
        return HTTPMethod.get;
      case OrdersAction.createAnOrder:
        return HTTPMethod.post;
      case OrdersAction.getAnOrder:
        return HTTPMethod.get;
      case OrdersAction.deleteAnOrder:
        return HTTPMethod.delete;
      case OrdersAction.editAnOrder:
        return HTTPMethod.put;
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
  Map<String, String> get query {
    final Map<String, String> queryParams = {};
    return queryParams;
  }

  @override
  dynamic get body {
    switch (action) {
      case OrdersAction.createAnOrder:
        return {
          'address_id': order?.location?.id,
          'card_id': order?.card?.id,
          'order_items': order?.products?.map((product) {
            return {
              'product_id': product.id,
              'quantity': product.existingQuantityInOrder,
            };
          }).toList() ?? [],
        };
      case OrdersAction.editAnOrder:

        return {
          'address_id': order?.location?.id,
          'order_items': order?.products?.map((product) {
            return {
              'product_id': product.id,
              'quantity': product.existingQuantityInOrder,
            };
          }).toList() ?? [],
        };
      case OrdersAction.getAnOrder:
      case OrdersAction.deleteAnOrder:
      case OrdersAction.getAllOrders:
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