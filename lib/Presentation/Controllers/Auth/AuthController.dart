import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Utils/ControllerHandling.dart';
import 'package:order_application/Data/Models/Location.dart';
import 'package:order_application/Domain/Usecases/auth_usecases/FillUserDataUseCase.dart';
import 'package:order_application/Domain/Usecases/auth_usecases/LogoutUseCase.dart';
import 'package:order_application/Domain/Usecases/auth_usecases/RegisterUserUseCase.dart';
import 'package:order_application/Domain/Usecases/auth_usecases/ResendVerificationCodeUseCase.dart';
import 'package:order_application/Domain/Usecases/auth_usecases/VerifyUserUseCase.dart';
import 'package:order_application/Data/Models/User.dart';

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

  double? latitude;
  double? longitude;
  Rx<File?> profileImage = Rx<File?>(null);

  RxMap<String, bool> loadingMap = <String, bool>{}.obs;
  RxMap<String, String?> errorMap = <String, String?>{}.obs;

  Rx<User> user = Rx<User>(User.empty());

  AuthController({
    required this.registerUserUseCase,
    required this.resendVerificationCodeUseCase,
    required this.verifyUserUseCase,
    required this.fillUserDataUseCase,
    required this.logoutUseCase,
  });

  // Method to update location
  void updateLocation(double lat, double lon) {
    latitude = lat;
    longitude = lon;
  }

  // Method to update the profile image
  void updateProfileImage(File image) {
    profileImage.value = image;
  }

  Future<void> registerUser() async {
    await controllerHandling(
      () async {
        user.value.phone = phoneController.text;
        final response = await registerUserUseCase.call(user.value);
      },
      loadingMap,
      'register_user',
      errorMap,
      'register_user',
    );
  }

  Future<void> resendVerificationCode() async {
    await controllerHandling(
      () async {
        final response = await resendVerificationCodeUseCase.call(user.value);
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
        user.value.otp = otpController.text;
        final response = await verifyUserUseCase.call(user.value);
      },
      loadingMap,
      'verify_user',
      errorMap,
      'verify_user',
    );
  }

  Future<void> fillStudentData() async {
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

        final response = await fillUserDataUseCase.call(user.value);
      },
      loadingMap,
      'fill_student_data',
      errorMap,
      'fill_student_data',
    );
  }

  Future<void> logoutUser() async {
    await controllerHandling(
      () async {
        final response = await logoutUseCase.call();
      },
      loadingMap,
      'logout_user',
      errorMap,
      'logout_user',
    );
  }
}