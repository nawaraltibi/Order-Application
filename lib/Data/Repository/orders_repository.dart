import 'package:get/get.dart';
import 'package:order_application/Data/Models/Order.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Providers/network/apis/orders_api.dart';
import 'package:order_application/Data/providers/network/api_provider.dart';
import 'package:order_application/Presentation/Controllers/SharedPreferences/SharedPreferencesController.dart';

class OrderRepository {
  final APIProvider _apiProvider = APIProvider.instance;

  Future<ResponseBody> getAllOrders() async {
    final request =
        OrdersAPI.getAllOrders(Get.find<SharedPreferencesController>().token);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<ResponseBody> createAnOrder(Order order) async {
    final request = OrdersAPI.createAnOrder(
        Get.find<SharedPreferencesController>().token, order);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<ResponseBody> getAnOrder(int id) async {
    final request =
        OrdersAPI.getAnOrder(Get.find<SharedPreferencesController>().token, id);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<void> deleteAnOrder(int id) async {
    final request = OrdersAPI.deleteAnOrder(
        Get.find<SharedPreferencesController>().token, id);
    await _apiProvider.request(request);
    return;
  }

  Future<ResponseBody> editAnOrder(Order order, int id) async {
    final request = OrdersAPI.editAnOrder(
        Get.find<SharedPreferencesController>().token, id, order);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<ResponseBody> getActiveOrder() async {
    final request =
    OrdersAPI.activeOrder(Get.find<SharedPreferencesController>().token);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<ResponseBody> getUnTakenOrders(int page) async {
    final request = OrdersAPI.unTakenOrders(
        Get.find<SharedPreferencesController>().token, page);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<ResponseBody> takeAnOrder(int id) async {
    final request = OrdersAPI.takeAnOrder(
        Get.find<SharedPreferencesController>().token, id);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<ResponseBody> deliverAnOrder(int id) async {
    final request = OrdersAPI.deliverAnOrder(
        Get.find<SharedPreferencesController>().token, id);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }
}
