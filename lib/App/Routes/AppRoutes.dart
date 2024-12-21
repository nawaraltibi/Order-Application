import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Auth/AuthBinding.dart';
import 'package:order_application/Presentation/Controllers/Dashboard/DashboardBinding.dart';
import 'package:order_application/Presentation/Pages/Dashboard/DashboardPage.dart';
import 'package:order_application/Presentation/Pages/Details/ProductDetailsScreen.dart';
import 'package:order_application/Presentation/Pages/Onboarding/OnboardingScreen.dart';
import 'package:order_application/Presentation/Pages/Payment/NewCardScreen.dart';
import 'package:order_application/Presentation/Pages/Payment/PaymentMethodsScreen.dart';
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
    GetPage(name: '/EnterNumber', page: () => EnterNumberScreen(), binding: AuthBinding()),
    GetPage(name: '/Verification', page: () => VerificationScreen(), ),
    GetPage(name: '/FillData', page: () => FillDataScreen(), ),
    GetPage(name: '/DashboardPage', page: () => DashboardPage(), binding: DashboardBinding(),),
    GetPage(name: '/EditInformation', page: () => EditInformationScreen()),
    GetPage(name: '/Language', page: () => LanguageScreen()),
    GetPage(name: '/About', page: () => AboutScreen()),
    GetPage(name: '/Details', page: () => ProductDetailsScreen()),
    GetPage(name: '/Payment', page: () => PaymentMethodsScreen()),
    GetPage(name: '/NewCard', page: () => NewCardScreen()),
  ];
}
