import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/App/Utils/ControllerHandling.dart';
import 'package:order_application/Data/Models/Location.dart';
import 'package:order_application/Domain/Usecases/auth_usecases/FillUserDataUseCase.dart';
import 'package:order_application/Domain/Usecases/auth_usecases/LogoutUseCase.dart';
import 'package:order_application/Domain/Usecases/auth_usecases/RegisterUserUseCase.dart';
import 'package:order_application/Domain/Usecases/auth_usecases/ResendVerificationCodeUseCase.dart';
import 'package:order_application/Domain/Usecases/auth_usecases/VerifyUserUseCase.dart';
import 'package:order_application/Data/Models/User.dart';
import 'package:order_application/Presentation/Controllers/SharedPreferences/SharedPreferencesController.dart';

class AuthController extends GetxController {
  final RegisterUserUseCase registerUserUseCase;
  final ResendVerificationCodeUseCase resendVerificationCodeUseCase;
  final VerifyUserUseCase verifyUserUseCase;
  final FillUserDataUseCase fillUserDataUseCase;
  final LogoutUseCase logoutUseCase;

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final SharedPreferencesController prefsController = Get.find<SharedPreferencesController>();

  bool isDelivery = false;
  double? latitude;
  double? longitude;
  Rx<File?> profileImage = Rx<File?>(null);

  RxMap<String, RxBool> loadingMap = <String, RxBool>{}.obs;
  RxMap<String, String?> errorMap = <String, String?>{}.obs;

  Rx<User> user = Rx<User>(User.empty());

  var statusMessage = ''.obs;
  var remainingTime = ''.obs;
  var isResendDisabled = false.obs;
  var remainingSeconds = 60.obs;
  Timer? timer;

  AuthController({
    required this.registerUserUseCase,
    required this.resendVerificationCodeUseCase,
    required this.verifyUserUseCase,
    required this.fillUserDataUseCase,
    required this.logoutUseCase,
  });

  @override
  void onInit() {
    super.onInit();
    loadingMap['register'] = false.obs;
    loadingMap['resend_verification_code'] = false.obs;
    loadingMap['verify'] = false.obs;
    loadingMap['fill_data'] = false.obs;
    loadingMap['logout'] = false.obs;
  }

  // Method to update location
  void updateLocation(double lat, double lon) {
    latitude = lat;
    longitude = lon;
  }

  // Method to update the profile image
  void updateProfileImage(File image) {
    profileImage.value = image;
  }

  void startResendTimer() {
    isResendDisabled.value = true;
    remainingSeconds.value = 60;
    updateStatusMessage();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
        remainingTime.value = formatRemainingTime(remainingSeconds.value);
      } else {
        timer.cancel();
        isResendDisabled.value = false;
        statusMessage.value = " resend";
      }
    });
  }

  String formatRemainingTime(int seconds) {
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  void updateStatusMessage() {
    if (isResendDisabled.value) {
      statusMessage.value = "Remaining time: ${remainingTime.value}";
    }
  }

  void register(){
    if(!isDelivery){
      registerUser();
    }else{

    }
  }

  void resend(){
    if(!isDelivery){
      resendUserVerificationCode;
    }else{

    }
  }

  void verify(){
    if(!isDelivery){
      verifyUser();
    }else{

    }
  }

  void logout(){
    if(!isDelivery){
      logoutUser;
    }else{

    }
  }

  Future<void> registerUser() async {
    await controllerHandling(
      () async {
        user.value.phone = phoneController.text;
        if (user.value.phone == null || !RegExp(r'^\+963\d{9}$').hasMatch(user.value.phone!)) {
          Get.snackbar('Failed', "Please enter a valid phone number starting with +963");
        }
        final ResponseBody response = await registerUserUseCase.call(user.value);
        Get.snackbar('Success', response.message);
        Get.toNamed("/Verification");
      },
      loadingMap,
      'register',
      errorMap,
      'register',
    );
  }

  Future<void> resendUserVerificationCode() async {
    await controllerHandling(
      () async {
        final ResponseBody response = await resendVerificationCodeUseCase.call(user.value);
        Get.snackbar('Success', response.message);
      },
      loadingMap,
      'resend_verification_code',
      errorMap,
      'resend_verification_code',
    );
  }

  Future<void> verifyUser() async {
    await controllerHandling(
      () async {
        print(otpController.text);
        user.value.otp = otpController.text;
        final ResponseBody response = await verifyUserUseCase.call(user.value);
        Get.snackbar('Success', response.message);
        print(response.data);
        print(response.userExists);
        if(response.userExists!){
          Get.toNamed("/DashboardPage");
        }else{
          Get.toNamed("/FillData");
        }
      },
      loadingMap,
      'verify',
      errorMap,
      'verify',
    );
  }

  Future<void> fillUserData() async {
    await controllerHandling(
      () async {
        user.value.image = profileImage.value;
        user.value.firstName = firstNameController.text;
        user.value.lastName = lastNameController.text;
        (latitude != null || longitude != null)
            ? user.value.locations?.add(Location(
                name: addressController.text,
                latitude: latitude!,
                longitude: longitude!))
            : null;

        final ResponseBody response = await fillUserDataUseCase.call(user.value);
        Get.snackbar('Success', response.message);
        Get.toNamed("/DashboardPage");
      },
      loadingMap,
      'fill_data',
      errorMap,
      'fill_data',
    );
  }

  Future<void> logoutUser() async {
    await controllerHandling(
      () async {
        final ResponseBody response = await logoutUseCase.call();
        Get.snackbar('Success', response.message);
        Get.toNamed("/EnterNumber");
      },
      loadingMap,
      'logout',
      errorMap,
      'logout',
    );
  }
}