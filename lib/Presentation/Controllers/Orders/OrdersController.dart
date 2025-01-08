import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Utils/ControllerHandling.dart';
import 'package:order_application/Data/Models/CreditCard.dart';
import 'package:order_application/Data/Models/Location.dart';
import 'package:order_application/Data/Models/Order.dart';
import 'package:order_application/Data/Models/OrderStatus.dart';
import 'package:order_application/Data/Models/Product.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Domain/Usecases/orders_usecases/GetAllOrdersUseCase.dart';
import 'package:order_application/Domain/Usecases/orders_usecases/CreateAnOrderUseCase.dart';
import 'package:order_application/Domain/Usecases/orders_usecases/DeleteAnOrderUseCase.dart';
import 'package:order_application/Domain/Usecases/orders_usecases/EditAnOrderUseCase.dart';
import 'package:order_application/Domain/Usecases/orders_usecases/GetAnOrderUseCase.dart';

import '../../../Domain/Usecases/rate_use_case/RateProductUseCase.dart';
import '../../Widgets/CustomAlertDialog.dart';
import '../User/UserController.dart';

class OrdersController extends GetxController {
  final GetAllOrdersUseCase getAllOrdersUseCase;
  final CreateAnOrderUseCase createAnOrderUseCase;
  final DeleteAnOrderUseCase deleteAnOrderUseCase;
  final EditAnOrderUseCase editAnOrderUseCase;
  final GetAnOrderUseCase getAnOrderUseCase;
  final RateProductUseCase rateProductUseCase;

  OrdersController({
    required this.getAllOrdersUseCase,
    required this.createAnOrderUseCase,
    required this.deleteAnOrderUseCase,
    required this.editAnOrderUseCase,
    required this.getAnOrderUseCase,
    required this.rateProductUseCase,
  });

  Rx<Order?> selectedOrder = Rx<Order?>(null);
  RxList<Order> orderItems = <Order>[].obs;
  RxMap<String, RxBool> loadingMap = <String, RxBool>{}.obs;
  RxMap<String, String?> errorMap = <String, String?>{}.obs;
  RxBool isRequestExpanded = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllOrders();
  }

  Future<void> fetchAllOrders() async {
    await controllerHandling(
      () async {
        final ResponseBody response = await getAllOrdersUseCase.call();
        orderItems.value = Order.fromListJson(response.data);
        orderItems.refresh();
      },
      loadingMap,
      'fetchAllOrders',
      errorMap,
      'fetchAllOrders',
    );
  }

  Future<void> createOrder(Order order) async {
    await controllerHandling(
      () async {
        await createAnOrderUseCase.call(order: order);
        await fetchAllOrders(); // Refresh the orders list after creation
      },
      loadingMap,
      'createOrder',
      errorMap,
      'createOrder',
    );
  }

  Future<void> deleteOrder(int id) async {
    await controllerHandling(
      () async {
        await deleteAnOrderUseCase.call(id: id);
        await fetchAllOrders(); // Refresh the orders list after deletion
      },
      loadingMap,
      'deleteOrder',
      errorMap,
      'deleteOrder',
    );
  }

  Future<void> editOrder(Order order) async {
    await controllerHandling(
      () async {
        await editAnOrderUseCase.call(order: order, id: order.id!);
        await fetchAllOrders(); // Refresh the orders list after deletion
        Get.back();
      },
      loadingMap,
      'editOrder',
      errorMap,
      'editOrder',
    );
  }

  Future<void> fetchOrderDetails(int id) async {
    final ResponseBody response = await getAnOrderUseCase.call(id: id);
    await controllerHandling(
      () async {
        selectedOrder.value = Order.fromJson(response.data);
      },
      loadingMap,
      'fetchOrderDetails',
      errorMap,
      'fetchOrderDetails',
    );
  }

  void goToEditOrderPage(var data) {
    Get.toNamed('/EditOrder',arguments: data);
  }

  void updateExpanded(Order order) {
    order.expanded = !order.expanded;
    orderItems.refresh();
  }

  void showDeleteRequestDialog(BuildContext context,Order order) {
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
          message: 'delete_confirmation'.tr,
          confirmText: 'Delete'.tr,
          cancelText: 'cancel'.tr,
          onConfirm: () {deleteOrder(order.id!);Get.back();},
          onCancel: () {Get.back();}),
    );
  }

  Future<bool> removeProduct(int? productId) async {
    bool isSuccess = false;
    try {
      bool confirmation = false;
      if (selectedOrder.value!.hasSingleProduct()) {
        await Get.dialog(
          CustomAlertDialog(
            message: 'are you sure you want to remove product?'.tr,
            onConfirm: () {
              isSuccess = true;
              confirmation = true;
              deleteOrder(selectedOrder.value!.id!);
              selectedOrder.refresh();
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
        selectedOrder.value!.removeProduct(productId!, requireConfirmation: confirmation);
        selectedOrder.refresh();
        isSuccess = true;
      }
    } catch (e) {
      errorMap['removeProduct'] = e.toString();
      Get.snackbar('Error', e.toString());
    }
    return isSuccess;
  }

  Rx<int> getProductQuantity(int productId) {
    return selectedOrder.value!.productById(productId).existingQuantityInOrder!.obs;
  }

  void incrementProductQuantity(int productId) {
    try {
      selectedOrder.value!.incrementProductQuantity(productId);
      selectedOrder.refresh();
    } catch (e) {
      errorMap['incrementProductQuantity'] = e.toString();
      Get.snackbar('Error', e.toString());
    }
  }

  void decrementProductQuantity(int productId) {
    try {
      selectedOrder.value!.decrementProductQuantity(productId);
      selectedOrder.refresh();
    } catch (e) {
      errorMap['decrementProductQuantity'] = e.toString();
      Get.snackbar('Error', e.toString());
    }
  }

  var productRatings = <int>[].obs;

  void initializeRatings(int productCount) {
    productRatings.value = List.generate(productCount, (_) => 0);
  }

  Future<void> updateStars(int productIndex, int rating, Product product) async {
    if (rating == 0 && productRatings[productIndex] == 1) {
      productRatings[productIndex] = 0;
    } else {
      productRatings[productIndex] = rating + 1;
    }

    await controllerHandling(
          () async {
        final ResponseBody response = await rateProductUseCase.call(
          rateableType: "product",
          rateableId: product.id!,
          rate: productRatings[productIndex],
        );

        Get.snackbar(response.message!,"The ${product.name} has been rated as ${rating+1} stars." );
      },
      loadingMap,
      'updateStars',
      errorMap,
      'updateStars',
    );
  }
}
