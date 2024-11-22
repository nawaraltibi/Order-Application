import 'package:get/get.dart';
import 'package:order_application/Presentation/Pages/Splash/SplashScreen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => SplashScreen()),
  ];
}
