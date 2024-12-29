import 'package:get/get.dart';
import 'package:order_application/Data/Models/Location.dart';
import 'package:order_application/Data/Models/Order.dart';
import 'package:order_application/Data/Models/OrderStatus.dart';
import 'package:order_application/Data/Models/Product.dart';

class CartController extends GetxController {
  Rx<Order> currentCart = Order(status: OrderStatus.cart).obs;
  RxMap<String, RxBool> loadingMap = <String, RxBool>{}.obs;
  RxMap<String, String?> errorMap = <String, String?>{}.obs;

  void addProduct(Product product) {
    try {
      currentCart.value.addProductToCart(product);
      currentCart.refresh();
    } catch (e) {
      errorMap['addProduct'] = e.toString();
      Get.snackbar('Error', e.toString());
    }
  }

  void removeProduct(int productId) {
    try {
      currentCart.value.removeProduct(productId, requireConfirmation: true);
      currentCart.refresh();
    } catch (e) {
      errorMap['removeProduct'] = e.toString();
      Get.snackbar('Error', e.toString());
    }
  }

  void incrementProductQuantity(int productId) {
    try {
      currentCart.value.incrementProductQuantity(productId);
      currentCart.refresh();
    } catch (e) {
      errorMap['incrementProductQuantity'] = e.toString();
      Get.snackbar('Error', e.toString());
    }
  }

  void decrementProductQuantity(int productId) {
    try {
      currentCart.value.decrementProductQuantity(productId);
      currentCart.refresh();
    } catch (e) {
      errorMap['decrementProductQuantity'] = e.toString();
      Get.snackbar('Error', e.toString());
    }
  }

  void updateLocation(Location location) {
    try {
      currentCart.value.updateLocation(location);
      currentCart.refresh();
    } catch (e) {
      errorMap['updateLocation'] = e.toString();
      Get.snackbar('Error', e.toString());
    }
  }

  void clearCart() {
    currentCart.value.products?.clear();
    currentCart.refresh();
  }
}
