import 'package:get/get.dart';
import 'package:order_application/Data/Models/Market.dart';

class Product {
  final int? id;
  final String? name;
  final String? descriptionEn;
  final String? descriptionAr;
  final int? price;
  final String? image;
  final double? rate;
  final int? stockQuantity;
  int? quantity;
  final int? totalSold;
  final String? categoryEn;
  final String? categoryAr;
  final bool? isFavorite;
  final Market? market;

  Product({
    this.id,
    this.name,
    this.descriptionEn,
    this.descriptionAr,
    this.price,
    this.image,
    this.rate,
    this.stockQuantity,
    this.quantity = 0,
    this.totalSold,
    this.categoryEn,
    this.categoryAr,
    this.isFavorite,
    this.market,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      descriptionEn: json['description_en'],
      descriptionAr: json['description_ar'],
      price: json['price'],
      image: json['image'],
      rate: json['rate']?.toDouble(),
      stockQuantity: json['stock_quantity'],
      totalSold: json['total_sold'],
      categoryEn: json['category_en'],
      categoryAr: json['category_ar'],
      isFavorite: json['is_favorite'],
      market: json['market'] != null ? Market.fromJson(json['market']) : null,
    );
  }

  static List<Product> fromListJson(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': id,
      'quantity': quantity,
    };
  }

  static List<Map<String, dynamic>> toListJson(List<Product>? productList) {
    if (productList == null) return [];
    return productList.map((product) => product.toJson()).toList();
  }

  String get description {
    return Get.locale?.languageCode == 'ar' ? (descriptionAr ?? '') : (descriptionEn ?? '');
  }

  String get category {
    return Get.locale?.languageCode == 'ar' ? (categoryAr ?? '') : (categoryEn ?? '');
  }

  void incrementQuantity() {
    if (quantity != null && stockQuantity != null && quantity! < stockQuantity!) {
      quantity = quantity! + 1;
    }
  }

  void decrementQuantity() {
    if (quantity != null && quantity! > 0) {
      quantity = quantity! - 1;
    }
  }
}