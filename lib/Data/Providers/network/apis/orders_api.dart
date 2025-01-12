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

  activeOrder,
  unTakenOrders,
  takeAnOrder,
  deliverAnOrder,
}

class OrdersAPI implements APIRequestRepresentable {
  final OrdersAction action;
  final String token;
  final Order? order;
  final int? id;
  final int? page;

  OrdersAPI._({
    required this.action,
    required this.token,
    this.order,
    this.id,
    this.page,
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
      : this._(
            action: OrdersAction.editAnOrder,
            token: token,
            id: id,
            order: order);

  OrdersAPI.activeOrder(String token)
      : this._(
          action: OrdersAction.activeOrder,
          token: token,
        );

  OrdersAPI.unTakenOrders(String token, int page)
      : this._(action: OrdersAction.unTakenOrders, token: token, page: page);

  OrdersAPI.takeAnOrder(String token, int id)
      : this._(action: OrdersAction.takeAnOrder, token: token, id: id);

  OrdersAPI.deliverAnOrder(String token, int id)
      : this._(action: OrdersAction.deliverAnOrder, token: token, id: id);

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
      case OrdersAction.activeOrder:
        return "/driver/orders/active";
      case OrdersAction.unTakenOrders:
      case OrdersAction.takeAnOrder:
        return "/driver/orders";
      case OrdersAction.deliverAnOrder:
        return "/driver/deliver-order";
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
      case OrdersAction.activeOrder:
        return HTTPMethod.get;
      case OrdersAction.unTakenOrders:
        return HTTPMethod.get;
      case OrdersAction.takeAnOrder:
        return HTTPMethod.post;
      case OrdersAction.deliverAnOrder:
        return HTTPMethod.post;
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
    queryParams['page'] = page.toString();
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
              }).toList() ??
              [],
        };
      case OrdersAction.editAnOrder:
        return {
          'address_id': order?.location?.id,
          'order_items': order?.products?.map((product) {
                return {
                  'product_id': product.id,
                  'quantity': product.existingQuantityInOrder,
                };
              }).toList() ??
              [],
        };
      case OrdersAction.getAnOrder:
      case OrdersAction.deleteAnOrder:
      case OrdersAction.getAllOrders:
      case OrdersAction.activeOrder:
      case OrdersAction.unTakenOrders:
        return null;
      case OrdersAction.takeAnOrder:
      case OrdersAction.deliverAnOrder:
        return {'order_id': id};
    }
  }

  @override
  Future<dynamic> request() async {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}