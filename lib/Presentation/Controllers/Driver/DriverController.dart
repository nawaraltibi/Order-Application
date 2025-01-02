import 'package:get/get.dart';

import '../../../Data/Models/CreditCard.dart';
import '../../../Data/Models/Location.dart';
import '../../../Data/Models/Order.dart';
import '../../../Data/Models/OrderStatus.dart';
import '../../../Data/Models/Product.dart';

class DriverController extends GetxController{
  List<Order> orders = [Order(
      id: 0,
      card: CreditCard(
          name: 'Nawar', cardNumber: '12345', expireDate: '1/4/2004', cvc: 0),
      createdAt: DateTime(2025, 1, 20),
      deliveryFee: 10,
      location: Location(
          id: 0,
          name: 'Home',
          latitude: 0,
          longitude: 0,
          street: 'Muhajereen',
          region: 'Shamsya'),
      status: OrderStatus.pendingConfirmation,
      totalCost: 9300,
      products: [
        Product(
            id: 0,
            name: 'Samsung Galaxy A35',
            image: 'assets/images/mobile.jpg',
            price: 2700,
            quantity: 2,
            existingQuantityInOrder: 2
        ),
        Product(
            id: 1,
            name: 'Samsung Galaxy A35',
            image: 'assets/images/mobile.jpg',
            price: 1700,
            quantity: 1,
            existingQuantityInOrder: 1
        ),
        Product(
            id: 2,
            name: 'Samsung Galaxy A35',
            image: 'assets/images/mobile.jpg',
            price: 1200,
            quantity: 2,
            existingQuantityInOrder: 2
        ),
      ])];

  var expandedOrders = <bool>[].obs;

  void initializeExpanded(int orderCount) {
    expandedOrders.value = List.generate(orderCount, (_) => false);
  }

  void updateExpanded(int orderIndex) {
    if(expandedOrders[orderIndex])
      expandedOrders[orderIndex] = false;
    else
      expandedOrders[orderIndex] = true;
  }
}