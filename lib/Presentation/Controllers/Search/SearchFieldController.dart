import 'package:get/get.dart';
import 'package:order_application/App/Utils/ControllerHandling.dart';
import 'package:order_application/Data/Models/Market.dart';
import 'package:order_application/Data/Models/Meta.dart';
import 'package:order_application/Data/Models/Product.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Models/SearchType.dart';
import 'package:order_application/Domain/Usecases/search_usecases/SearchUseCase.dart';

class SearchFieldController extends GetxController {
  final SearchUseCase searchUseCase;

  Rx<Meta?> meta = Rx<Meta?>(null);
  RxList<Product> products = <Product>[].obs;
  RxList<Market> markets = <Market>[].obs;
  Rx<SearchType> selectedFilter = SearchType.products.obs;
  RxString searchQuery = ''.obs;
  RxMap<String, RxBool> loadingMap = <String, RxBool>{}.obs;
  RxMap<String, String?> errorMap = <String, String?>{}.obs;
  Map<String, int> activeRequests = <String, int>{};

  SearchFieldController({required this.searchUseCase});

  @override
  void onInit() {
    super.onInit();
    loadingMap['searchProducts'] = false.obs;
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    if (query.trim().isNotEmpty) {
      search();
    } else {
      clearResults();
    }
  }

  void onFilterChanged(SearchType filter) {
    selectedFilter.value = filter;
    if (searchQuery.value.isNotEmpty) {
      search();
    }
  }

  void clearResults() {
    if (selectedFilter.value == SearchType.products) {
      products.clear();
    } else if (selectedFilter.value == SearchType.markets) {
      markets.clear();
    }
  }

  Future<void> search({
    int page = 1,
  }) async {
    await controllerHandling(
      () async {
        final ResponseBody response = await searchUseCase.call(
            searchType: selectedFilter.value,
            word: searchQuery.value,
            page: page);

        if(selectedFilter.value == SearchType.products){
          if(page == 1){
            products.value = Product.fromListJson(response.data);
          }else{
            products.addAll(Product.fromListJson(response.data));
          }
        }else if(selectedFilter.value == SearchType.markets){
          if(page == 1){
            markets.value = Market.fromListJson(response.data);
          }else{
            markets.addAll(Market.fromListJson(response.data));
          }
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

  bool getNextSearchPage() {
    if (meta.value != null && meta.value!.currentPage < meta.value!.lastPage) {
      search(page: meta.value!.currentPage + 1);
      return true;
    }
    return false;
  }
}