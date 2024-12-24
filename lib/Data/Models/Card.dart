
class Card {
  int? id;
  final String name;
  final String cardNumber;
  final String expireDate;
  final int cvc;

  Card({
    this.id,
    required this.name,
    required this.cardNumber,
    required this.expireDate,
    required this.cvc,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'card_number': cardNumber,
      'expire_date': expireDate,
      'cvc': cvc,
    };
  }

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      id: json['id'] as int,
      name: json['name'] as String,
      cardNumber: json['card_number'] as String,
      expireDate: json['expire_date'] as String,
      cvc: json['cvc'] as int,
    );
  }

  static List<Card> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => Card.fromJson(json)).toList();
  }

  @override
  String toString() {
    return 'Card(name: $name, card number: $cardNumber, expire date: $expireDate, cvc: $cvc)';
  }
}
