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
      case "في السلة":
        return OrderStatus.cart;
      case "Waiting for confirmation":
      case "بانتظار التأكيد":
        return OrderStatus.pendingConfirmation;
      case "On the way":
      case "قيد التوصيل":
        return OrderStatus.inDelivery;
      case "Delivered":
      case "تم التوصيل":
        return OrderStatus.delivered;
      default:
        throw Exception("Invalid order status: $status");
    }
  }
}