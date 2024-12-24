import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {

  // Function to check if the user is opening the app for the first time
  Future<void> check() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the value that indicates whether the user has used the app before
    var isFirstTime = prefs.getBool('isFirstTime') ?? true;
    var token = prefs.getString('token');

    // If it's the first use, update the value to false for the next time and navigate to Onboarding
    if (isFirstTime) {
      await prefs.setBool('isFirstTime', false);
      Get.offAllNamed('/Onboarding');
      return;
    }
    // If the user is not logged in, navigate to the login screen
    if (token == null || token.isEmpty) {
      Get.offAllNamed('/EnterNumber');
      return;
    }
    // Otherwise, navigate to the home screen
    Get.offAllNamed('/DashboardPage');
  }
}