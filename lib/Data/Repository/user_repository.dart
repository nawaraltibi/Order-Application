import 'package:get/get.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Providers/network/apis/user_api.dart';
import 'package:order_application/Data/providers/network/api_provider.dart';
import 'package:order_application/Presentation/Controllers/SharedPreferences/SharedPreferencesController.dart';

class UserRepository {
  final APIProvider _apiProvider = APIProvider.instance;

  Future<ResponseBody> getAuthenticatedUser() async {
    final request = UserAPI.getAuthenticatedUser(Get.find<SharedPreferencesController>().token,);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }
}