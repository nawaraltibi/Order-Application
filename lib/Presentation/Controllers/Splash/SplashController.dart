import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  var isFirstTime = true;

  // Function to check if the user is opening the app for the first time
  Future<void> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the value that indicates whether the user has used the app before
    isFirstTime = prefs.getBool('isFirstTime') ?? true;
    bool? requireStudentData = prefs.getBool('requireStudentData');
    var token = prefs.getString('token');

    // If it's the first use, update the value to false for the next time
    if (isFirstTime) {
      await prefs.setBool('isFirstTime', false);
      //TODO Here, you can add navigation to a welcome or intro screen for new users
      return;
    }

    // If there is no token (user is not logged in), navigate to the login or start screen
    if (token == null) {
      //TODO Here, you can add Binding the AuthBinding for navigation
      //TODO Here, you can add navigation to the login screen
      return;
    }

    // If the token exists but the user needs to complete their data, navigate to the profile setup screen
    if (requireStudentData == true) {
      //TODO Here, you can add Binding the AuthBinding for navigation
      //TODO Here, you can add navigation to the profile creation screen
    } else {
      //TODO Here, you can add Binding the HomeBinding for navigation
      //TODO Here, you can add navigation to the home screen
    }
  }
}
