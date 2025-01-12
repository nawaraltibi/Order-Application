import 'package:order_application/Data/Models/CreditCard.dart';
import 'package:order_application/Data/Models/Location.dart';
import 'package:order_application/Data/Models/Market.dart';
import 'package:order_application/Data/Models/OrderStatus.dart';
import 'package:order_application/Data/Models/Product.dart';

class Order {
  int? id;
  List<Product>? products;
  List<Market>? markets;
  Location? location;
  CreditCard? card;
  OrderStatus status;
  double? totalCost;
  double? deliveryFee;
  DateTime? deliveredAt;
  DateTime? createdAt;
  bool expanded = false;
  String? geometry;

  Order({
    this.id,
    this.products,
    this.markets,
    this.location,
    this.card,
    this.status = OrderStatus.cart,
    this.totalCost = 0,
    this.deliveryFee = 1000.0,
    this.deliveredAt,
    this.createdAt,
  }) ;

  @override
  String toString() {
    return 'Order{id: $id, products: $products, location: $location, card: $card, status: $status, totalCost: $totalCost, deliveryFee: $deliveryFee, deliveredAt: $deliveredAt, createdAt: $createdAt}';
  }

  Map<String, dynamic> toJson() {
    return {
      'address_id': location?.id,
      'card_id': card?.id,
      'order_items': products != null ? Product.toListJson(products!) : [],
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int?,
      products: (json['products'] as List?)
          ?.map((product) => Product.fromJson(product))
          .toList(),
      markets: json['markets'] != null
          ? Market.fromListJson(json['markets'])
          : [],
      location: json['address'] != null ? Location.fromJson(json['address']) : null,
      card: json['card'] != null ? CreditCard.fromJson(json['card']) : null,
      status: json['status_en'] != null ? OrderStatus.fromString(json['status_en']): OrderStatus.pendingConfirmation,
      totalCost: json['total_cost']?.toDouble(),
      deliveredAt: json['delivered_at'] != null
          ? DateTime.parse(json['delivered_at'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  static List<Order> fromListJson(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList.map((json) => Order.fromJson(json)).toList();
  }

  void addProductToCart(Product product) {
    if (!_isCart()) {
      throw Exception("Products can only be added to the cart.");
    }

    if (product.quantity == null || product.quantity! <= 0) {
      throw Exception("Product quantity must be greater than zero.");
    }
    products ??= [];
    final existingProduct =
    products!.firstWhere((p) => p.id == product.id, orElse: () => product);

    existingProduct.addToCart();
    if (!products!.contains(existingProduct)) {
      products!.add(existingProduct);
    }
    updateTotalCost();
  }

  Product productById(int id){
    return products!.firstWhere((p) => p.id == id);
  }

  void adjustProductQuantity(int productId, int delta) {
    final product = products!.firstWhere(
          (p) => p.id == productId,
      orElse: () => throw Exception("Product not found."),
    );

    int newQuantity = (product.existingQuantityInOrder ?? 0) + delta;

    if (newQuantity <= 0) {
      throw Exception("Cannot reduce quantity to zero.");
    }

    if (isEditable()) {
      if (newQuantity > product.originalQuantityInOrder!) {
        throw Exception(
            "Cannot exceed the originally ordered quantity (${product.originalQuantityInOrder}).");
      }
    } else {
      if (newQuantity > product.availableToAdd!) {
        throw Exception("Cannot exceed available stock.");
      }
      product.availableToAdd = product.stockQuantity! - newQuantity;
    }

    product.existingQuantityInOrder = newQuantity;

    updateTotalCost();
  }

  void incrementProductQuantity(int productId) {
    adjustProductQuantity(productId, 1);
  }

  void decrementProductQuantity(int productId) {
    adjustProductQuantity(productId, -1);
  }

  void removeProduct(int productId, {bool requireConfirmation = false}) {
    if (!canEditProduct(false)) {
      throw Exception("Cannot remove product in the current order state.");
    }

    final productExists = products?.any((p) => p.id == productId) ?? false;
    if (!productExists) {
      throw Exception("Product not found.");
    }

    if (hasSingleProduct() && requireConfirmation == false) {
      throw Exception(
          "You are about to remove the last product. Set `requireConfirmation` to true to confirm.");
    }



    final productToRemove = products!.firstWhere((p) => p.id == productId);


    productToRemove.existingQuantityInOrder = 0;
    productToRemove.availableToAdd = productToRemove.stockQuantity;
    productToRemove.quantity = 1;

    if(_isCart()){
      products?.removeWhere((p) => p.id == productId);
    }

    updateTotalCost();
  }

  bool isOrderEmpty() {
    return products == null || products!.isEmpty;
  }

  bool hasSingleProduct() {
    return products != null && products!.length == 1;
  }

  void updateLocation(Location newLocation){
    if (!isEditable()) {
      throw Exception("Cannot modify the order in its current state.");
    }

    location = newLocation;

    updateTotalCost();
  }

  void updateCard(CreditCard newCard) {
    if (!_isCart()) {
      throw Exception("Cannot modify the order in its current state.");
    }

    card = newCard;

    updateTotalCost();
  }

  void moveToNextStatus() {
    switch (status) {
      case OrderStatus.cart:
        status = OrderStatus.pendingConfirmation;
        break;
      case OrderStatus.pendingConfirmation:
        status = OrderStatus.inDelivery;
        break;
      case OrderStatus.inDelivery:
        status = OrderStatus.delivered;
        break;
      case OrderStatus.delivered:
        throw Exception("The order has already been delivered.");
    }

    updateTotalCost();
  }

  void updateTotalCost() {
    if (products == null || products!.isEmpty) {
      totalCost = 0.0;
      return;
    }

    double productsTotal = products!.fold(0.0, (sum, product) => sum + (product.price! * (product.existingQuantityInOrder ?? 1)));
    totalCost = productsTotal + (deliveryFee ?? 10.0);
  }

  bool _isCart() {
    return status == OrderStatus.cart;
  }

  bool isEditable() {
    return status == OrderStatus.pendingConfirmation ||
        status == OrderStatus.inDelivery;
  }

  bool canEditProduct(bool isAdding) {
    if (isAdding) {
      return _isCart();
    } else {
      return isEditable() || _isCart();
    }
  }
}