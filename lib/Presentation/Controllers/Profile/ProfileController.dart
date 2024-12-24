import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Utils/ControllerHandling.dart';
import 'package:order_application/Data/Models/Card.dart';
import 'package:order_application/Data/Models/Location.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/Data/Models/User.dart';
import 'package:order_application/Data/Providers/network/api_endpoint.dart';
import 'package:order_application/Domain/Usecases/address_usecases/CreateAnAddressUseCase.dart';
import 'package:order_application/Domain/Usecases/address_usecases/DeleteAnAddressUseCase.dart';
import 'package:order_application/Domain/Usecases/address_usecases/GetAllAddressUseCase.dart';
import 'package:order_application/Domain/Usecases/address_usecases/GetAnAddressUseCase.dart';
import 'package:order_application/Domain/Usecases/auth_usecases/LogoutUseCase.dart';
import 'package:order_application/Domain/Usecases/card_usecases/CreateAnCardsUseCase.dart';
import 'package:order_application/Domain/Usecases/card_usecases/DeleteAnCardsUseCase.dart';
import 'package:order_application/Domain/Usecases/card_usecases/GetAllCardsUseCase.dart';
import 'package:order_application/Domain/Usecases/card_usecases/GetAnCardsUseCase.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:order_application/Presentation/Controllers/SharedPreferences/SharedPreferencesController.dart';
import 'package:order_application/Presentation/Controllers/User/UserController.dart';

class ProfileController extends GetxController {
  final CreateAnAddressUseCase createAnAddressUseCase;
  final DeleteAnAddressUseCase deleteAnAddressUseCase;
  final GetAllAddressUseCase getAllAddressUseCase;
  final GetAnAddressUseCase getAnAddressUseCase;

  final CreateAnCardsUseCase createAnCardsUseCase;
  final DeleteAnCardsUseCase deleteAnCardsUseCase;
  final GetAllCardsUseCase getAllCardsUseCase;
  final GetAnCardsUseCase getAnCardsUseCase;

  final LogoutUseCase logoutUseCase;

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController nameOnCardController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvcController = TextEditingController();
  TextEditingController addressNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  double? latitude;
  double? longitude;
  Rx<File?> profileImage = Rx<File?>(null);

  // Variables to hold the dynamic text
  RxString cardNumber = "XXXX XXXX XXXX XXXX".obs;
  RxString cardName = "Name on card".obs;
  RxString expiryDate = "Expiry date".obs;

  RxMap<String, RxBool> loadingMap = <String, RxBool>{}.obs;
  RxMap<String, String?> errorMap = <String, String?>{}.obs;

  ProfileController({
    required this.createAnAddressUseCase,
    required this.deleteAnAddressUseCase,
    required this.getAllAddressUseCase,
    required this.getAnAddressUseCase,
    required this.createAnCardsUseCase,
    required this.deleteAnCardsUseCase,
    required this.getAllCardsUseCase,
    required this.getAnCardsUseCase,
    required this.logoutUseCase,
  });

  @override
  void onInit() {
    super.onInit();
    loadingMap['createAnAddress'] = false.obs;
    loadingMap['deleteAnAddress'] = false.obs;
    loadingMap['getAllAddress'] = false.obs;
    loadingMap['getAnAddress'] = false.obs;
    loadingMap['createAnCards'] = false.obs;
    loadingMap['deleteAnCards'] = false.obs;
    loadingMap['getAllCards'] = false.obs;
    loadingMap['getAnCards'] = false.obs;
    loadingMap['editUserData'] = false.obs;
    loadingMap['logout'] = false.obs;
  }

  // Method to update the profile image
  void updateProfileImage(File image) {
    profileImage.value = image;
  }

  Future<void> createAnAddress() async {
    await controllerHandling(
      () async {
        Location address = Location(
            name: addressNameController.text,
            latitude: latitude!,
            longitude: longitude!);
        final ResponseBody response =
            await createAnAddressUseCase.call(address);
      },
      loadingMap,
      'createAnAddress',
      errorMap,
      'createAnAddress',
    );
  }

  Future<void> deleteAnAddress(int id) async {
    await controllerHandling(
      () async {
        await deleteAnAddressUseCase.call(id);
        Get.find<UserController>().user.value.locations?.removeWhere((location) => location.id == id);
      },
      loadingMap,
      'deleteAnAddress',
      errorMap,
      'deleteAnAddress',
    );
  }

  Future<void> getAllAddress() async {
    await controllerHandling(
          () async {
        final ResponseBody response = await getAllAddressUseCase.call();
        final locations = Location.fromJsonList(response.data);
        for (var location in locations) {
          await location.fetchLocationDetails();
        }
        Get.find<UserController>().user.value.locations = locations;
      },
      loadingMap,
      'getAllAddress',
      errorMap,
      'getAllAddress',
    );
  }

  Future<void> getAnAddress(int id) async {
    await controllerHandling(
      () async {
        final ResponseBody response = await getAnAddressUseCase.call(id);
      },
      loadingMap,
      'getAnAddress',
      errorMap,
      'getAnAddress',
    );
  }

  Future<void> createAnCards() async {
    await controllerHandling(
      () async {
        Card card = Card(
            name: nameOnCardController.text,
            cardNumber: cardNumberController.text,
            expireDate: expiryDateController.text,
            cvc: int.parse(cvcController.text));
        final ResponseBody response = await createAnCardsUseCase.call(card);
        Get.find<UserController>().user.value.cards!.add(Card.fromJson(response.data));
        Get.back();
        Get.snackbar('Success', response.message!);
      },
      loadingMap,
      'createAnCards',
      errorMap,
      'createAnCards',
    );
  }

  Future<void> deleteAnCards(int id) async {
    await controllerHandling(
      () async {
        await deleteAnCardsUseCase.call(id);
        Get.find<UserController>().user.value.cards?.removeWhere((card) => card.id == id);
      },
      loadingMap,
      'deleteAnCards',
      errorMap,
      'deleteAnCards',
    );
  }

  Future<void> getAllCards() async {
    await controllerHandling(
      () async {
        final ResponseBody response = await getAllCardsUseCase.call();
        Get.find<UserController>().user.value.cards = Card.fromJsonList(response.data);
      },
      loadingMap,
      'getAllCards',
      errorMap,
      'getAllCards',
    );
  }

  Future<void> getAnCards(int id) async {
    await controllerHandling(
      () async {
        final ResponseBody response = await getAnCardsUseCase.call(id);
      },
      loadingMap,
      'getAnCards',
      errorMap,
      'getAnCards',
    );
  }

  Future<void> editUserData() async {
    await controllerHandling(
      () async {
        User user = User(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            image: profileImage.value);

        var request = http.MultipartRequest(
          'POST',
          Uri.parse("${APIEndpoint.API}/user"),
        )
          ..fields['first_name'] = user.firstName!
          ..fields['last_name'] = user.lastName!
          ..fields['_method'] = 'PUT';

        if (user.image != null) {
          var file = http.MultipartFile.fromBytes(
            'profile_picture',
            await File(user.image!.path).readAsBytes(),
            filename: user.image!.path.split('/').last,
            contentType: MediaType('application', 'jpg'),
          );
          request.files.add(file);
        }

        request.headers.addAll({
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${Get.find<SharedPreferencesController>().token}',
        });
        var response = await request.send();
        final responseString = await response.stream.bytesToString();
        final responseBody = ResponseBody.fromJson(jsonDecode(responseString));

        if (response.statusCode == 200) {
          User updatedUser = User.fromJson(responseBody.data);
          Get.find<UserController>().user.value.name = updatedUser.name;
          Get.find<UserController>().user.value.firstName =
              updatedUser.firstName;
          Get.find<UserController>().user.value.lastName = updatedUser.lastName;
          Get.find<UserController>().user.value.imageName =
              updatedUser.imageName;

          Get.toNamed("/DashboardPage");
        } else {
          Get.snackbar('Error', responseBody.message!);
        }
      },
      loadingMap,
      'editUserData',
      errorMap,
      'editUserData',
    );
  }

  Future<void> logoutUser() async {
    await controllerHandling(
      () async {
        await logoutUseCase.call();
        Get.find<SharedPreferencesController>().clearData();
        Get.toNamed("/EnterNumber");
      },
      loadingMap,
      'logout',
      errorMap,
      'logout',
    );
  }
}
