import 'package:get/get.dart';
import 'package:order_application/App/Utils/ControllerHandling.dart';
import 'package:order_application/Data/Models/Meta.dart';
import 'package:order_application/Data/Models/Product.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';
import '../../../Domain/Usecases/markets_use_case/GetMarketProductsUseCase.dart';

class MarketProductsController extends GetxController {
  final GetMarketProductsUseCase getMarketProductsUseCase;

  Rx<Meta?> meta = Rx<Meta?>(null);
  RxList<Product> products = <Product>[].obs;
  RxString searchQuery = ''.obs;
  RxInt marketId = 0.obs;
  RxMap<String, RxBool> loadingMap = <String, RxBool>{}.obs;
  RxMap<String, String?> errorMap = <String, String?>{}.obs;
  Map<String, int> activeRequests = <String, int>{};

  MarketProductsController({required this.getMarketProductsUseCase});

  @override
  void onInit() {
    super.onInit();
    loadingMap['getMarketProducts'] = false.obs;
    loadingMap['searchProducts'] = false.obs;
  }

  void setMarketId(int id) {
    marketId.value = id;
    fetchMarketProducts();
  }

  void clearProducts() {
    products.clear();
  }

  Future<void> fetchMarketProducts({int page = 1}) async {
    await controllerHandling(
          () async {
        final ResponseBody response = await getMarketProductsUseCase.call(
          marketId: marketId.value,
          page: page,
        );

        if (page == 1) {
          products.value = Product.fromListJson(response.data);
        } else {
          products.addAll(Product.fromListJson(response.data));
        }
        meta.value = response.meta;
      },
      loadingMap,
      'getMarketProducts',
      errorMap,
      'getMarketProducts',
      activeRequests: activeRequests,
      activeRequestsKey: 'getMarketProducts',
    );
  }

  bool getNextProductsPage() {
    if (meta.value != null && meta.value!.currentPage < meta.value!.lastPage) {
      fetchMarketProducts(page: meta.value!.currentPage + 1);
      return true;
    }
    return false;
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    if (query.trim().isNotEmpty) {
      searchProducts();
    } else {
      fetchMarketProducts();
    }
  }

  Future<void> searchProducts({int page = 1}) async {
    await controllerHandling(
          () async {
        final ResponseBody response = await getMarketProductsUseCase.call(
          marketId: marketId.value,
          page: page,
        );

        final List<Product> filteredProducts = Product.fromListJson(response.data)
            .where((product) => product.name!.toLowerCase().contains(searchQuery.value.toLowerCase()))
            .toList();

        if (page == 1) {
          products.value = filteredProducts;
        } else {
          products.addAll(filteredProducts);
        }
        meta.value = response.meta;
      },
      loadingMap,
      'searchProducts',
      errorMap,
      'searchProducts',
      activeRequests: activeRequests,
      activeRequestsKey: 'searchProducts',
    );
  }
}
