import 'package:get/get.dart';
import 'package:order_application/Data/Models/CreditCard.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Providers/network/apis/cards_api.dart';
import 'package:order_application/Data/providers/network/api_provider.dart';
import 'package:order_application/Presentation/Controllers/SharedPreferences/SharedPreferencesController.dart';

class CardRepository {
  final APIProvider _apiProvider = APIProvider.instance;

  Future<ResponseBody> getAllCards() async {
    final request = CardAPI.getAllCards(Get.find<SharedPreferencesController>().token);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<ResponseBody> createAnCards(CreditCard card) async {
    final request = CardAPI.createAnCards(Get.find<SharedPreferencesController>().token, card);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<ResponseBody> getAnCards(int id) async {
    final request = CardAPI.getAnCards(Get.find<SharedPreferencesController>().token, id);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  Future<void> deleteAnCards(int id) async {
    final request = CardAPI.deleteAnCards(Get.find<SharedPreferencesController>().token, id);
    await _apiProvider.request(request);
    return;
  }
}
