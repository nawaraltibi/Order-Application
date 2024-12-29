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
  RxList<Product> products = <Product>[].obs;
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
        final ResponseBody response = await addRemoveFavoriteUseCase.call(id: id);
        product.isFavorite = !product.isFavorite!;
        meta.value = response.meta;
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
        final ResponseBody response = await showFavoritesUseCase.call(
            page: page);

        if(page == 1){
          products.value = Product.fromListJson(response.data);
        }else{
          products.addAll(Product.fromListJson(response.data));
        }

        meta.value = response.meta;
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
      showFavorites(page: meta.value!.currentPage + 1);
      return true;
    }
    return false;
  }
}