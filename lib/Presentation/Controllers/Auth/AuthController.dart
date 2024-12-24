import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:order_application/Data/Models/ResponseBody.dart';
import 'package:order_application/App/Utils/ControllerHandling.dart';
import 'package:order_application/Data/Models/Location.dart';
import 'package:order_application/Domain/Usecases/auth_usecases/RegisterUserUseCase.dart';
import 'package:order_application/Domain/Usecases/auth_usecases/ResendVerificationCodeUseCase.dart';
import 'package:order_application/Domain/Usecases/auth_usecases/VerifyUserUseCase.dart';
import 'package:order_application/Data/Models/User.dart';
import 'package:order_application/Presentation/Controllers/SharedPreferences/SharedPreferencesController.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:order_application/Data/providers/network/api_endpoint.dart';
import 'package:order_application/Presentation/Controllers/User/UserController.dart';

class AuthController extends GetxController {
  final RegisterUserUseCase registerUserUseCase;
  final ResendVerificationCodeUseCase resendVerificationCodeUseCase;
  final VerifyUserUseCase verifyUserUseCase;

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
  });

  @override
  void onInit() {
    super.onInit();
    loadingMap['register'] = false.obs;
    loadingMap['resend_verification_code'] = false.obs;
    loadingMap['verify'] = false.obs;
    loadingMap['fill_data'] = false.obs;
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
    remainingTime.value = formatRemainingTime(remainingSeconds.value);

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
        remainingTime.value = formatRemainingTime(remainingSeconds.value);
      } else {
        timer.cancel();
        isResendDisabled.value = false;
        statusMessage.value = "resend".tr;
      }
    });
  }

  String formatRemainingTime(int seconds) {
    int minutes = (seconds ~/ 60);
    int secs = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  void updateStatusMessage() {
    if (isResendDisabled.value) {
      statusMessage.value = remainingTime.value;
    }
  }

  void register(){
    user.value.phone = phoneController.text;
    if (user.value.phone == null || !RegExp(r'^\+963\d{9}$').hasMatch(user.value.phone!)) {
      Get.snackbar('Failed', "Please enter a valid phone number starting with +963");
      return;
    }
    if(!isDelivery){
      registerUser();
    }else{

    }
  }

  void resend(){
    if(!isDelivery){
      resendUserVerificationCode();
    }else{

    }
  }

  void verify(){
    if(!isDelivery){
      verifyUser();
    }else{

    }
  }

  Future<void> registerUser() async {
    await controllerHandling(
      () async {
        final ResponseBody response = await registerUserUseCase.call(user.value);
        Get.snackbar('Success', response.message!);
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
        Get.snackbar('Success', response.message!);
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
        final ResponseBody response = await verifyUserUseCase.call(user.value);
        Get.snackbar('Success', response.message!);
        if(response.userExists!){
          Get.find<SharedPreferencesController>().saveData('token',response.token!);
          Get.toNamed("/DashboardPage");
          Get.find<UserController>().user.value = User.fromJson(response.data);
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

        if (latitude != null && longitude != null) {
          user.value.locations ??= [];
          user.value.locations!.add(Location(
            name: addressController.text,
            latitude: latitude!,
            longitude: longitude!,
          ));
        }

        var request = http.MultipartRequest(
          'POST',
          Uri.parse("${APIEndpoint.API}/user/register"),
        )
          ..fields['first_name'] = user.value.firstName!
          ..fields['last_name'] = user.value.lastName!
          ..fields['phone'] = user.value.phone!;

        if (user.value.image != null) {
          var file = http.MultipartFile.fromBytes(
            'profile_picture',
            await File(user.value.image!.path).readAsBytes(),
            filename: user.value.image!.path.split('/').last,
            contentType: MediaType('application', 'jpg'),
          );
          request.files.add(file);
        }

        if (user.value.locations != null && user.value.locations!.isNotEmpty) {
          for (int i = 0; i < user.value.locations!.length; i++) {
            request.fields['addresses[$i][name]'] = user.value.locations![i].name;
            request.fields['addresses[$i][location_longitude]'] =
                user.value.locations![i].longitude.toString();
            request.fields['addresses[$i][location_latitude]'] =
                user.value.locations![i].latitude.toString();
          }
        }
        request.headers.addAll({
          'Accept': 'application/json',
        });

        var response = await request.send();
        final responseString = await response.stream.bytesToString();
        final responseBody = ResponseBody.fromJson(jsonDecode(responseString));

        if (response.statusCode == 201) {
          Get.snackbar('Success', responseBody.message!);
          Get.find<SharedPreferencesController>().saveData('token',responseBody.token!);
          Get.toNamed("/DashboardPage");
          Get.find<UserController>().user.value = User.fromJson(responseBody.data);
        } else {
          Get.snackbar('Error', responseBody.message!);
        }
      },
      loadingMap,
      'fill_data',
      errorMap,
      'fill_data',
    );
  }
}