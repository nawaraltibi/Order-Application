import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Splash/SplashController.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => SplashController());

  }
}