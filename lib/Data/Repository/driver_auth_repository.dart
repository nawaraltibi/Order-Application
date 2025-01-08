import 'package:get/get.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Models/Driver.dart';
import 'package:order_application/Data/providers/network/api_provider.dart';
import 'package:order_application/Data/providers/network/apis/driver_auth_api.dart';
import 'package:order_application/Presentation/Controllers/SharedPreferences/SharedPreferencesController.dart';

class DriverAuthRepository {
  final APIProvider _apiProvider = APIProvider.instance;

  Future<ResponseBody> registerDriver(Driver driver) async {
    final request = DriverAuthAPI.register(driver);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<ResponseBody> resendVerificationCode(Driver driver) async {
    final request = DriverAuthAPI.resendVerificationCode(driver);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<ResponseBody> verifyDriver(Driver driver) async {
    final request = DriverAuthAPI.verify(driver);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<void> logout() async {
    final request = DriverAuthAPI.logout(Get.find<SharedPreferencesController>().token);
    await _apiProvider.request(request);
    return ;
  }
}