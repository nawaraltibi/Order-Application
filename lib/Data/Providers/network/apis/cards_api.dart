import 'package:order_application/Data/Models/Card.dart';
import 'package:order_application/Data/providers/network/api_endpoint.dart';
import 'package:order_application/Data/providers/network/api_provider.dart';
import 'package:order_application/Data/providers/network/api_request_representable.dart';

enum CardsAction {
  getAllCards,
  createAnCards,
  getAnCards,
  deleteAnCards,
}

class CardAPI implements APIRequestRepresentable {
  final CardsAction action;
  final String token;
  final Card? card;
  final int? id;

  CardAPI._({
    required this.action,
    required this.token,
    this.card,
    this.id,
  });

  // Constructor for get All Cards action
  CardAPI.getAllCards(String token) : this._(action: CardsAction.getAllCards, token: token);

  // Constructor for create An Cards action
  CardAPI.createAnCards(String token, Card card)
      : this._(action: CardsAction.createAnCards, token: token, card: card);

  // Constructor for get An Cards action
  CardAPI.getAnCards(String token, int id) : this._(action: CardsAction.getAnCards, token: token, id: id);

  // Constructor for delete An Cards action
  CardAPI.deleteAnCards(String token, int id) : this._(action: CardsAction.deleteAnCards, token: token, id: id);

  @override
  String get endpoint => APIEndpoint.API;

  @override
  String get path {
    switch (action) {
      case CardsAction.getAllCards:
      case CardsAction.createAnCards:
        return "/user/cards";
      case CardsAction.getAnCards:
        return "/user/cards/$id";
      case CardsAction.deleteAnCards:
        return "/user/cards/$id";
    }
  }

  @override
  HTTPMethod get method {
    switch (action) {
      case CardsAction.getAllCards:
        return HTTPMethod.get;
      case CardsAction.createAnCards:
        return HTTPMethod.post;
      case CardsAction.getAnCards:
        return HTTPMethod.get;
      case CardsAction.deleteAnCards:
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
      case CardsAction.createAnCards:
        return {
          'name': card?.name,
          'card_number': card?.cardNumber,
          'expire_date': card?.expireDate,
          'cvc': card?.cvc,
        };
      case CardsAction.getAllCards:
      case CardsAction.getAnCards:
      case CardsAction.deleteAnCards:
        return null;
    }
  }

  Future<dynamic> request() async {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}
