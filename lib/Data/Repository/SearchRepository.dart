import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Models/SearchType.dart';
import 'package:order_application/Data/Providers/network/apis/search_api.dart';
import 'package:order_application/Data/Providers/network/api_provider.dart';
import 'package:order_application/Presentation/Controllers/SharedPreferences/SharedPreferencesController.dart';
import 'package:get/get.dart';

class SearchRepository {
  final APIProvider _apiProvider = APIProvider.instance;

  Future<ResponseBody> searchProducts({
    required SearchType searchType,
    required String word,
    required int page,
  }) async {
    final String token = Get.find<SharedPreferencesController>().token;

    final searchTypeString = searchType.toString().split('.').last;

    final searchAPI = SearchAPI.search(
      token: token,
      searchType: searchTypeString,
      word: word,
      page: page,
    );

    final response = await _apiProvider.request(searchAPI);
    return ResponseBody.fromJson(response);
  }
}
