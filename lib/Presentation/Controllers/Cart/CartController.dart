import 'package:get/get.dart';
import 'package:order_application/Data/Models/Location.dart';
import 'package:order_application/Data/Models/Order.dart';
import 'package:order_application/Data/Models/OrderStatus.dart';
import 'package:order_application/Data/Models/Product.dart';
import 'package:order_application/Presentation/Widgets/CustomAlertDialog.dart';

class CartController extends GetxController {
  Rx<Order> currentCart = Order(status: OrderStatus.cart).obs;
  RxMap<String, RxBool> loadingMap = <String, RxBool>{}.obs;
  RxMap<String, String?> errorMap = <String, String?>{}.obs;

  bool isCartEmpty() {
    try {
      return currentCart.value.isOrderEmpty();
    } catch (e) {
      errorMap['isCartEmpty'] = e.toString();
      Get.snackbar('Error', e.toString());
    }
    return false;
  }

  Rx<int> getProductQuantity(int productId) {
    return currentCart.value.productById(productId).existingQuantityInOrder!.obs;
  }

  void addProduct(Product product) {
    try {
      currentCart.value.addProductToCart(product);
      currentCart.refresh();
    } catch (e) {
      Get.snackbar('Error', '$e');
      errorMap['addProduct'] = e.toString();
    }
  }

  Future<bool> removeProduct(int? productId) async {
    bool isSuccess = false;
    try {
      bool confirmation = false;

      if (currentCart.value.hasSingleProduct()) {
        await Get.dialog(
          CustomAlertDialog(
            message: 'are you sure you want to remove product?'.tr,
            onConfirm: () {
              isSuccess = true;
              confirmation = true;
              currentCart.value.removeProduct(productId!, requireConfirmation: confirmation);
              currentCart.refresh();
              Get.back();
              Get.back();
            },
            onCancel: () {
              Get.back();
            },
            confirmText: 'Yes'.tr,
            cancelText: 'No'.tr,
          ),
          barrierDismissible: false,
        );
      } else {
        currentCart.value.removeProduct(productId!, requireConfirmation: confirmation);
        currentCart.refresh();
        isSuccess = true;
      }
    } catch (e) {
      errorMap['removeProduct'] = e.toString();
      Get.snackbar('Error', e.toString());
    }
    return isSuccess;
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

  var isExpanded = false.obs;

  void toggleExpanded() => isExpanded.value = !isExpanded.value;

}
