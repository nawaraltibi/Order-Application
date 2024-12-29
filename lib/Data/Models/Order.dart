import 'package:order_application/Data/Models/Card.dart';
import 'package:order_application/Data/Models/Location.dart';
import 'package:order_application/Data/Models/OrderStatus.dart';
import 'package:order_application/Data/Models/Product.dart';

class Order {
  int? id;
  List<Product>? products;
  Location? location;
  Card? card;
  OrderStatus status;
  double? totalCost;
  double? deliveryFee;
  DateTime? deliveredAt;
  DateTime? createdAt;

  Order({
    this.id,
    this.products,
    this.location,
    this.card,
    this.status = OrderStatus.cart,
    this.totalCost,
    this.deliveryFee = 10.0,
    this.deliveredAt,
    this.createdAt,
  }) {
    _updateTotalCost();
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
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
      card: json['card'] != null ? Card.fromJson(json['card']) : null,
      status: OrderStatus.values
          .firstWhere((e) => e.toString() == 'OrderStatus.${json['status']}'),
      totalCost: json['totalCost'] != null ? (json['totalCost'] as num).toDouble() : null,
      deliveryFee: json['deliveryFee'] != null ? (json['deliveryFee'] as num).toDouble() : 10.0,
      deliveredAt: json['deliveredAt'] != null
          ? DateTime.parse(json['deliveredAt'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
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

    int availableToAdd = product.stockQuantity! - (existingProduct.quantity ?? 0);

    if (availableToAdd <= 0) {
      throw Exception("Product stock exceeded.");
    }

    int quantityToAdd =  (product.quantity! > availableToAdd) ? availableToAdd : product.quantity!;
    existingProduct.quantity = (existingProduct.quantity ?? 0) + quantityToAdd;
    if (!products!.contains(existingProduct)) {
      products!.add(existingProduct);
    }

    _updateTotalCost();
  }

  void adjustProductQuantity(int productId, int delta) {
    if (!_canEditProduct(delta > 0)) {
      throw Exception("Cannot adjust product quantity in the current order state.");
    }

    final product = products!.firstWhere(
            (p) => p.id == productId,
        orElse: () => throw Exception("Product not found."));

    int newQuantity = (product.quantity ?? 0) + delta;
    if (newQuantity <= 0) {
      products!.remove(product);
    } else if (delta > 0 && newQuantity > product.stockQuantity!) {
      throw Exception("Exceeds available stock.");
    } else {
      product.quantity = newQuantity;
    }

    _updateTotalCost();
  }

  void incrementProductQuantity(int productId) {
    adjustProductQuantity(productId, 1);
  }

  void decrementProductQuantity(int productId) {
    adjustProductQuantity(productId, -1);
  }

  void removeProduct(int productId, {bool requireConfirmation = false}) {
    if (!_canEditProduct(false)) {
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

    products?.removeWhere((p) => p.id == productId);

    _updateTotalCost();
  }

  bool isOrderEmpty() {
    return products == null || products!.isEmpty;
  }

  bool hasSingleProduct() {
    return products != null && products!.length == 1;
  }

  void updateLocation(Location newLocation) {
    if (!_isEditable()) {
      throw Exception("Cannot modify the order in its current state.");
    }

    location = newLocation;

    _updateTotalCost();
  }

  void updateCard(Card newCard) {
    if (!_isCart()) {
      throw Exception("Cannot modify the order in its current state.");
    }

    card = newCard;

    _updateTotalCost();
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

    _updateTotalCost();
  }

  void _updateTotalCost() {
    if (products == null || products!.isEmpty) {
      totalCost = 0.0;
      return;
    }

    double productsTotal = products!.fold(0.0, (sum, product) => sum + (product.price! * (product.quantity ?? 1)));
    totalCost = productsTotal + (deliveryFee ?? 10.0);
  }

  bool _isCart() {
    return status == OrderStatus.cart;
  }

  bool _isEditable() {
    return status == OrderStatus.pendingConfirmation ||
        status == OrderStatus.inDelivery;
  }

  bool _isDelivered() {
    return status == OrderStatus.delivered;
  }

  bool _canEditProduct(bool isAdding) {
    if (isAdding) {
      return _isCart();
    } else {
      return _isEditable() || _isCart();
    }
  }
}