import 'package:get/get.dart';
import '../../../App/Utils/ControllerHandling.dart';
import '../../../Data/Models/Product.dart';
import '../../../Data/Models/ResponseBody.dart';
import '../../../Domain/Usecases/products_use_case/GetBestSellingProductsUseCase.dart';
import '../../../Domain/Usecases/products_use_case/GetForYouProductsUseCase.dart';
import '../../../Domain/Usecases/products_use_case/GetTopRatedProductsUseCase.dart';

class HomeController extends GetxController {
  final GetBestSellingProductsUseCase getBestSellingProductsUseCase;
  final GetTopRatedProductsUseCase getTopRatedProductsUseCase;
  final GetForYouProductsUseCase getForYouProductsUseCase;


  HomeController({
    required this.getBestSellingProductsUseCase,
    required this.getTopRatedProductsUseCase,
    required this.getForYouProductsUseCase,
  });

  RxList<Product> topRated = <Product>[].obs;
  RxList<Product> bestSelling = <Product>[].obs;
  RxList<Product> forYou = <Product>[].obs;
  RxMap<String, RxBool> loadingMap = <String, RxBool>{}.obs;
  RxMap<String, String?> errorMap = <String, String?>{}.obs;
  RxString categoryEn = ''.obs;
  RxString categoryAr = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadingMap['getBestSellingProducts'] = false.obs;
    loadingMap['getTopRatedProducts'] = false.obs;
    loadingMap['getForYouProducts'] = false.obs;
    getBestSellingProducts();
    getTopRatedProducts();
    getForYouProducts();
  }

  Future<void> getBestSellingProducts() async {
    await controllerHandling(
          () async {
            final ResponseBody response =
            await getBestSellingProductsUseCase.call();
            bestSelling.value = Product.fromListJson(response.data);
            bestSelling.refresh();
          },
      loadingMap,
      'getBestSellingProducts',
      errorMap,
      'getBestSellingProducts',
    );
  }

  Future<void> getTopRatedProducts() async {
    await controllerHandling(
          () async {
        final ResponseBody response =
        await getTopRatedProductsUseCase.call();
        topRated.value = Product.fromListJson(response.data);
        topRated.refresh();
      },
      loadingMap,
      'getTopRatedProducts',
      errorMap,
      'getTopRatedProducts',
    );
  }

  Future<void> getForYouProducts() async {

    await controllerHandling(
          () async {
            final ResponseBody response =
            await getForYouProductsUseCase.call();
            forYou.value = Product.fromListJson(response.data['products']);
            categoryEn.value = response.data['name_en'];
            categoryAr.value = response.data['name_ar'];
            categoryAr.refresh();
            categoryEn.refresh();
            forYou.refresh();
          },
      loadingMap,
      'getForYouProducts',
      errorMap,
      'getForYouProducts',
    );
  }

  String get category {
    return Get.locale?.languageCode == 'ar'
        ? (categoryAr.value)
        : (categoryEn.value);
  }
}