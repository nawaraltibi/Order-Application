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

import '../../Widgets/CustomAlertDialog.dart';
import '../User/UserController.dart';

class OrdersController extends GetxController {
  final GetAllOrdersUseCase getAllOrdersUseCase;
  final CreateAnOrderUseCase createAnOrderUseCase;
  final DeleteAnOrderUseCase deleteAnOrderUseCase;
  final EditAnOrderUseCase editAnOrderUseCase;
  final GetAnOrderUseCase getAnOrderUseCase;

  OrdersController({
    required this.getAllOrdersUseCase,
    required this.createAnOrderUseCase,
    required this.deleteAnOrderUseCase,
    required this.editAnOrderUseCase,
    required this.getAnOrderUseCase,
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

  Future<void> editOrder(Order order, int id) async {
    await controllerHandling(
      () async {
        await editAnOrderUseCase.call(order: order, id: id);
        await fetchAllOrders(); // Refresh the orders list after editing
      },
      loadingMap,
      'editOrder',
      errorMap,
      'editOrder',
    );
  }

  Future<void> fetchOrderDetails(int id) async {
    await controllerHandling(
      () async {
        final ResponseBody response = await getAnOrderUseCase.call(id: id);
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

  var productRatings = <int>[].obs;

  void initializeRatings(int productCount) {
    productRatings.value = List.generate(productCount, (_) => 0);
  }

  void updateStars(int productIndex, int rating) {
    if (rating == 0 && productRatings[productIndex] == 1) {
      productRatings[productIndex] = 0;
    } else {
      productRatings[productIndex] = rating + 1;
    }
  }

}
