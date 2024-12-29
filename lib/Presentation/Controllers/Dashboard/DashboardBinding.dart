import 'package:get/get.dart';
import 'package:order_application/Data/Repository/favorites_repository.dart';
import 'package:order_application/Data/Repository/orders_repository.dart';
import 'package:order_application/Data/Repository/search_repository.dart';
import 'package:order_application/Data/Repository/auth_repository.dart';
import 'package:order_application/Data/Repository/card_repository.dart';
import 'package:order_application/Data/Repository/address_repository.dart';
import 'package:order_application/Domain/Usecases/auth_usecases/LogoutUseCase.dart';
import 'package:order_application/Domain/Usecases/favorites_usecases/AddRemoveFavoriteUseCase.dart';
import 'package:order_application/Domain/Usecases/favorites_usecases/ShowFavoritesUseCase.dart';
import 'package:order_application/Domain/Usecases/orders_usecases/CreateAnOrderUseCase.dart';
import 'package:order_application/Domain/Usecases/orders_usecases/DeleteAnOrderUseCase.dart';
import 'package:order_application/Domain/Usecases/orders_usecases/EditAnOrderUseCase.dart';
import 'package:order_application/Domain/Usecases/orders_usecases/GetAllOrdersUseCase.dart';
import 'package:order_application/Domain/Usecases/orders_usecases/GetAnOrderUseCase.dart';
import 'package:order_application/Domain/Usecases/search_usecases/SearchUseCase.dart';
import 'package:order_application/Presentation/Controllers/Cart/CartController.dart';
import 'package:order_application/Presentation/Controllers/Dashboard/DashboardController.dart';
import 'package:order_application/Presentation/Controllers/Favorites/FavoritesController.dart';
import 'package:order_application/Presentation/Controllers/Home/HomeController.dart';
import 'package:order_application/Presentation/Controllers/Orders/OrdersController.dart';
import 'package:order_application/Presentation/Controllers/Profile/ProfileController.dart';
import 'package:order_application/Presentation/Controllers/Search/SearchFieldController.dart';
import 'package:order_application/Domain/Usecases/address_usecases/CreateAnAddressUseCase.dart';
import 'package:order_application/Domain/Usecases/address_usecases/DeleteAnAddressUseCase.dart';
import 'package:order_application/Domain/Usecases/address_usecases/GetAllAddressUseCase.dart';
import 'package:order_application/Domain/Usecases/address_usecases/GetAnAddressUseCase.dart';
import 'package:order_application/Domain/Usecases/card_usecases/CreateAnCardsUseCase.dart';
import 'package:order_application/Domain/Usecases/card_usecases/DeleteAnCardsUseCase.dart';
import 'package:order_application/Domain/Usecases/card_usecases/GetAllCardsUseCase.dart';
import 'package:order_application/Domain/Usecases/card_usecases/GetAnCardsUseCase.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardController>(DashboardController(), permanent: true);

    Get.put<CartController>(CartController(), permanent: true);

    Get.put<FavoriteController>(FavoriteController(addRemoveFavoriteUseCase: AddRemoveFavoriteUseCase(FavoritesRepository()), showFavoritesUseCase: ShowFavoritesUseCase(FavoritesRepository())), permanent: true);

    Get.put<HomeController>(HomeController(), permanent: true);

    Get.put<SearchFieldController>(
      SearchFieldController(
        searchUseCase: SearchUseCase(SearchRepository()),
      ),
      permanent: true,
    );

    Get.lazyPut<OrdersController>(() => OrdersController(
        getAllOrdersUseCase: GetAllOrdersUseCase(OrderRepository()),
        createAnOrderUseCase: CreateAnOrderUseCase(OrderRepository()),
        deleteAnOrderUseCase: DeleteAnOrderUseCase(OrderRepository()),
        editAnOrderUseCase: EditAnOrderUseCase(OrderRepository()),
        getAnOrderUseCase: GetAnOrderUseCase(OrderRepository())));

    Get.put<ProfileController>(
      ProfileController(
        createAnAddressUseCase: CreateAnAddressUseCase(AddressRepository()),
        deleteAnAddressUseCase: DeleteAnAddressUseCase(AddressRepository()),
        getAllAddressUseCase: GetAllAddressUseCase(AddressRepository()),
        getAnAddressUseCase: GetAnAddressUseCase(AddressRepository()),
        createAnCardsUseCase: CreateAnCardsUseCase(CardRepository()),
        deleteAnCardsUseCase: DeleteAnCardsUseCase(CardRepository()),
        getAllCardsUseCase: GetAllCardsUseCase(CardRepository()),
        getAnCardsUseCase: GetAnCardsUseCase(CardRepository()),
        logoutUseCase: LogoutUseCase(AuthRepository()),
      ),
      permanent: true,
    );
  }
}