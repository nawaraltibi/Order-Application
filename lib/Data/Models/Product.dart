import 'package:get/get.dart';
import 'package:order_application/Data/Models/Market.dart';

class Product {
  final int id;
  final String name;
  final String descriptionEn;
  final String descriptionAr;
  final int price;
  final String image;
  final double rate;
  final int stockQuantity;
  final int totalSold;
  final String categoryEn;
  final String categoryAr;
  final bool isFavorite;
  final Market market;

  Product({
    required this.id,
    required this.name,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.price,
    required this.image,
    required this.rate,
    required this.stockQuantity,
    required this.totalSold,
    required this.categoryEn,
    required this.categoryAr,
    required this.isFavorite,
    required this.market,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      descriptionEn: json['description_en'],
      descriptionAr: json['description_ar'],
      price: json['price'],
      image: json['image'],
      rate: json['rate'].toDouble(),
      stockQuantity: json['stock_quantity'],
      totalSold: json['total_sold'],
      categoryEn: json['category_en'],
      categoryAr: json['category_ar'],
      isFavorite: json['is_favorite'],
      market: Market.fromJson(json['market']),
    );
  }

  static List<Product> fromListJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description_en': descriptionEn,
      'description_ar': descriptionAr,
      'price': price,
      'image': image,
      'rate': rate,
      'stock_quantity': stockQuantity,
      'total_sold': totalSold,
      'category_en': categoryEn,
      'category_ar': categoryAr,
      'is_favorite': isFavorite,
      'market': market.toJson(),
    };
  }

  String get description {
    return Get.locale?.languageCode == 'ar' ? descriptionAr : descriptionEn;
  }

  String get category {
    return Get.locale?.languageCode == 'ar' ? categoryAr : categoryEn;
  }
}