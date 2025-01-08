import 'location.dart';

class Market {
  final int id;
  final String name;
  final double rate;
  final String logo;
  final int rateCount;
  final Location? address;

  Market({
    required this.id,
    required this.name,
    required this.rate,
    required this.logo,
    required this.rateCount,
    this.address,
  });

  factory Market.fromJson(Map<String, dynamic> json) {
    return Market(
      id: json['id'],
      name: json['name'],
      rate: double.parse(json['rate']),
      logo: json['logo'],
      rateCount: json['rate_count'],
      address: json['address'] != null
          ? Location.fromJson(json['address'])
          : null,
    );
  }

  static List<Market> fromListJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Market.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rate': rate,
      'logo': logo,
      'rate_count': rateCount,
      'address': address?.toJson(),
    };
  }
}