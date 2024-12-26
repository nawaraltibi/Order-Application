class Market {
  final int id;
  final String name;
  final double rate;
  final String logo;

  Market({
    required this.id,
    required this.name,
    required this.rate,
    required this.logo,
  });

  factory Market.fromJson(Map<String, dynamic> json) {
    return Market(
      id: json['id'],
      name: json['name'],
      rate: json['rate'].toDouble(),
      logo: json['logo'],
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
    };
  }
}