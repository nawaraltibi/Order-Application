import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Providers/network/apis/favorites_api.dart';
import 'package:order_application/Data/Providers/network/api_provider.dart';
import 'package:order_application/Presentation/Controllers/SharedPreferences/SharedPreferencesController.dart';
import 'package:get/get.dart';

class FavoritesRepository {
  final APIProvider _apiProvider = APIProvider.instance;

  Future<ResponseBody> showFavorites({
    required int page,
  }) async {
    final String token = Get.find<SharedPreferencesController>().token;

    final favoritesAPI = FavoritesAPI.showFavorites(
      token: token,
      page: page,
    );

    final response = await _apiProvider.request(favoritesAPI);
    return ResponseBody.fromJson(response);
  }

  Future<void> addRemove({
    required int productId,
  }) async {
    final String token = Get.find<SharedPreferencesController>().token;

    final favoritesAPI = FavoritesAPI.addRemove(
      token: token,
      productId: productId,
    );

    final response = await _apiProvider.request(favoritesAPI);
    return;
  }
}