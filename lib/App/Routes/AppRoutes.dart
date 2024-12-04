import 'package:get/get.dart';
import 'package:order_application/Presentation/Pages/Onboarding/OnboardingScreen.dart';
import 'package:order_application/Presentation/Pages/Registration/EnterPhoneNumberScreen.dart';
import 'package:order_application/Presentation/Pages/Registration/FillDataScreen.dart';
import 'package:order_application/Presentation/Pages/Splash/SplashScreen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: '/Onboarding', page: () => OnboardingScreen()),
    GetPage(name: '/EnterNumber', page: () => EnterNumberScreen()),
    GetPage(name: '/FillData', page: () => FillDataScreen()),
  ];
}
