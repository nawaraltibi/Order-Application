import 'package:get/get.dart';
import 'package:order_application/Data/Models/Location.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Providers/network/apis/addresses_api.dart';
import 'package:order_application/Data/providers/network/api_provider.dart';
import 'package:order_application/Presentation/Controllers/SharedPreferences/SharedPreferencesController.dart';

class AddressRepository {
  final APIProvider _apiProvider = APIProvider.instance;

  Future<ResponseBody> getAllAddress() async {
    final request = AddressAPI.getAllAddresses(Get.find<SharedPreferencesController>().token);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<ResponseBody> createAnAddress(Location location) async {
    final request = AddressAPI.createAnAddress(Get.find<SharedPreferencesController>().token, location);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<ResponseBody> getAnAddress(int id) async {
    final request = AddressAPI.getAnAddress(Get.find<SharedPreferencesController>().token, id);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<void> deleteAnAddress(int id) async {
    final request = AddressAPI.deleteAnAddress(Get.find<SharedPreferencesController>().token, id);
    await _apiProvider.request(request);
    return;
  }
}
