import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_application/Data/Repository/auth_repository.dart';
import 'package:order_application/Data/Repository/card_repository.dart';
import 'package:order_application/Data/Repository/address_repository.dart';
import 'package:order_application/Domain/Usecases/auth_usecases/LogoutUseCase.dart';
import 'package:order_application/Presentation/Controllers/Dashboard/DashboardController.dart';
import 'package:order_application/Presentation/Controllers/Home/HomeController.dart';
import 'package:order_application/Presentation/Controllers/Orders/OrdersController.dart';
import 'package:order_application/Presentation/Controllers/Profile/ProfileController.dart';
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
    Get.lazyPut<DashboardController>(() => DashboardController());

    Get.lazyPut<HomeController>(() => HomeController());

    Get.lazyPut<SearchController>(() => SearchController());

    Get.lazyPut<OrdersController>(() => OrdersController());

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