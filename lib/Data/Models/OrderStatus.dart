import 'package:get/get.dart';

enum OrderStatus {
  cart,
  pendingConfirmation,
  inDelivery,
  delivered;


  String get nameEn {
    switch (this) {
      case OrderStatus.cart:
        return "Cart";
      case OrderStatus.pendingConfirmation:
        return "Pending Confirmation";
      case OrderStatus.inDelivery:
        return "In Delivery";
      case OrderStatus.delivered:
        return "Delivered";
    }
  }

  String get nameAr {
    switch (this) {
      case OrderStatus.cart:
        return "في السلة";
      case OrderStatus.pendingConfirmation:
        return "في انتظار التأكيد";
      case OrderStatus.inDelivery:
        return "قيد التوصيل";
      case OrderStatus.delivered:
        return "تم التسليم";
    }
  }

  String get name {
    return Get.locale?.languageCode == 'ar' ? nameAr  : nameEn ;
  }

  static OrderStatus fromString(String status) {
    switch (status) {
      case "cart":
        return OrderStatus.cart;
      case "waiting for confirmation":
        return OrderStatus.pendingConfirmation;
      case "on the way":
        return OrderStatus.inDelivery;
      case "delivered":
        return OrderStatus.delivered;
      default:
        throw Exception("Invalid order status: $status");
    }
  }
}