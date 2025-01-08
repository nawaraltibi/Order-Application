import 'package:get/get.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Providers/network/apis/rate_api.dart';
import 'package:order_application/Data/Providers/network/api_provider.dart';
import 'package:order_application/Presentation/Controllers/SharedPreferences/SharedPreferencesController.dart';

class RateRepository {
  final APIProvider _apiProvider = APIProvider.instance;

  Future<ResponseBody> rate({
    required String rateableType,
    required int rateableId,
    required int rate,
  }) async {
    final String token = Get.find<SharedPreferencesController>().token;

    final request = RateAPI.rate(
      token,
      rateableType,
      rateableId,
      rate,
    );

    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }
}