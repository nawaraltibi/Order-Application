
import 'package:get/get.dart';
import '../../Presentation/Controllers/SharedPreferences/SharedPreferencesController.dart';
import '../Models/ResponseBody.dart';
import '../Providers/network/api_provider.dart';
import '../Providers/network/apis/markets_api.dart';

class MarketsRepository {
  final APIProvider _apiProvider = APIProvider.instance;

  Future<ResponseBody> getProducts({
    required int marketId,
    required int page,
  }) async {

    final request = MarketsAPI.getProducts(
      Get.find<SharedPreferencesController>().token,
      marketId,
      page,
    );

    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }
}
