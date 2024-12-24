import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/User/UserController.dart';

class DashboardController extends GetxController {
  var lastTabIndex = 0;
  var tabIndex = 0;

  @override
  void onInit() {
    super.onInit();
    Get.find<UserController>().getAuthenticatedUser();
  }

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