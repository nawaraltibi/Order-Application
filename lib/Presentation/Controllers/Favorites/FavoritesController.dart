import 'package:get/get.dart';
import 'package:order_application/App/Utils/ControllerHandling.dart';
import 'package:order_application/Data/Models/Meta.dart';
import 'package:order_application/Data/Models/Product.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Domain/Usecases/favorites_usecases/AddRemoveFavoriteUseCase.dart';
import 'package:order_application/Domain/Usecases/favorites_usecases/ShowFavoritesUseCase.dart';

class FavoriteController extends GetxController {
  final AddRemoveFavoriteUseCase addRemoveFavoriteUseCase;
  final ShowFavoritesUseCase showFavoritesUseCase;

  Rx<Meta?> meta = Rx<Meta?>(null);
  RxList<Product> allProducts = <Product>[].obs;
  RxList<Product> searchedProducts = <Product>[].obs;
  RxMap<String, RxBool> loadingMap = <String, RxBool>{}.obs;
  RxMap<String, String?> errorMap = <String, String?>{}.obs;
  Map<String, int> activeRequests = <String, int>{};

  FavoriteController({required this.addRemoveFavoriteUseCase, required this.showFavoritesUseCase});

  Future<void> addRemoveFavorite({
    required int id,
    required Product product,
  }) async {
    await controllerHandling(
          () async {
        await addRemoveFavoriteUseCase.call(id: id);
        product.isFavorite = !product.isFavorite!;

        final index = allProducts.indexWhere((p) => p.id == product.id);
        if (index != -1) {
          allProducts[index] = product;
          allProducts.refresh();
        }
        showFavorites();
      },
      loadingMap,
      'addRemoveFavorite',
      errorMap,
      'addRemoveFavorite',
    );
  }

  Future<void> showFavorites({
    int page = 1,
  }) async {
    await controllerHandling(
          () async {
        final ResponseBody response = await showFavoritesUseCase.call(page: page);

        if (page == 1) {
          allProducts.value = Product.fromListJson(response.data);
        } else {
          allProducts.addAll(Product.fromListJson(response.data));
        }

        meta.value = response.meta;
        searchFavorites("");
      },
      loadingMap,
      'showFavorites',
      errorMap,
      'showFavorites',
      activeRequests: activeRequests,
      activeRequestsKey: 'searchProducts',
    );
  }

  bool getNextSearchPage() {
    if (meta.value != null && meta.value!.currentPage < meta.value!.lastPage) {
      showFavorites(page: meta.value!.currentPage + 1,);
      return true;
    }
    return false;
  }

  Future<void> searchFavorites(String query) async {
    searchedProducts.clear();

    if (query.isEmpty) {
      searchedProducts.addAll(allProducts);
      return;
    }

    final filteredProducts = allProducts.where((product) {
      return product.name != null &&
          product.name!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    searchedProducts.addAll(filteredProducts);
  }
}