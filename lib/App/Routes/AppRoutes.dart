import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Dashboard/DashboardBinding.dart';
import 'package:order_application/Presentation/Pages/Dashboard/DashboardPage.dart';
import 'package:order_application/Presentation/Pages/Onboarding/OnboardingScreen.dart';
import 'package:order_application/Presentation/Pages/Profile/AboutScreen.dart';
import 'package:order_application/Presentation/Pages/Profile/LanguageScreen.dart';
import 'package:order_application/Presentation/Pages/Registration/EnterPhoneNumberScreen.dart';
import 'package:order_application/Presentation/Pages/Registration/FillDataScreen.dart';
import 'package:order_application/Presentation/Pages/Registration/VerificationScreen.dart';
import 'package:order_application/Presentation/Pages/Splash/SplashScreen.dart';

import '../../Presentation/Pages/Profile/EditInformationScreen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: '/Onboarding', page: () => OnboardingScreen()),
    GetPage(name: '/EnterNumber', page: () => EnterNumberScreen()),
    GetPage(name: '/Verification', page: () => VerificationScreen()),
    GetPage(name: '/FillData', page: () => FillDataScreen()),
    GetPage(name: '/DashboardPage', page: () => DashboardPage(), binding: DashboardBinding(),),
    GetPage(name: '/EditInformation', page: () => EditInformationScreen()),
    GetPage(name: '/Language', page: () => Languagescreen()),
    GetPage(name: '/About', page: () => AboutScreen()),
  ];
}
