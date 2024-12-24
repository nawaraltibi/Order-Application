import 'package:get/get.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Models/User.dart';
import 'package:order_application/Data/providers/network/api_provider.dart';
import 'package:order_application/Data/providers/network/apis/auth_api.dart';
import 'package:order_application/Presentation/Controllers/SharedPreferences/SharedPreferencesController.dart';

class AuthRepository {
  final APIProvider _apiProvider = APIProvider.instance;

  Future<ResponseBody> registerUser(User user) async {
    final request = AuthAPI.register(user);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<ResponseBody> resendVerificationCode(User user) async {
    final request = AuthAPI.resendVerificationCode(user);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<ResponseBody> verifyUser(User user) async {
    final request = AuthAPI.verify(user);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<void> logout() async {
    final request = AuthAPI.logout(Get.find<SharedPreferencesController>().token);
    await _apiProvider.request(request);
    return ;
  }
}
