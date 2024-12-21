import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/SharedPreferences/SharedPreferencesController.dart';

class SplashController extends GetxController {

  // Getting instance of SharedPreferencesController
  final SharedPreferencesController prefsController = Get.find<SharedPreferencesController>();

  // Function to check if the user is opening the app for the first time
  Future<void> check() async {

    // If it's the first use, update the value to false for the next time and navigate to Onboarding
    if (!prefsController.isFirstTime) {
      await prefsController.saveBool('isFirstTime', false);
      Get.offAllNamed('/Onboarding');
      return;
    }

    // If the user is not logged in, navigate to the login screen
    if (prefsController.token.isEmpty) {
      Get.offAllNamed('/EnterNumber');
      return;
    }

    // Otherwise, navigate to the home screen
    Get.offAllNamed('/DashboardPage');
  }
}