import 'package:get/get.dart';

class DashboardController extends GetxController {
  var lastTabIndex = 0;
  var tabIndex = 0;

  void changeTabIndex(int index) {
    lastTabIndex = tabIndex;
    tabIndex = index;
    update();
  }

  void goToHome() {
    tabIndex = 0;
    update();
  }
}