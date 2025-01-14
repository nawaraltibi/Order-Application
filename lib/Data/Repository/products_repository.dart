import 'package:get/get.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/providers/network/api_provider.dart';
import '../../Presentation/Controllers/SharedPreferences/SharedPreferencesController.dart';
import '../Providers/network/apis/products_api.dart';

class ProductsRepository {
  final APIProvider _apiProvider = APIProvider.instance;

  // Fetch Best Selling Products
  Future<ResponseBody> fetchBestSelling() async {
    final request = ProductsAPI.bestSelling(Get.find<SharedPreferencesController>().token);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  // Fetch Top Rated Products
  Future<ResponseBody> fetchTopRated() async {
    final request = ProductsAPI.topRated(Get.find<SharedPreferencesController>().token);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }

  // Fetch Top Rated Products
  Future<ResponseBody> fetchForYou() async {
    final request = ProductsAPI.forYou(Get.find<SharedPreferencesController>().token);
    final response = await _apiProvider.request(request);
    return ResponseBody.fromJson(response);
  }
}
