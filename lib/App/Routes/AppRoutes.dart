import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Auth/AuthBinding.dart';
import 'package:order_application/Presentation/Controllers/Dashboard/DashboardBinding.dart';
import 'package:order_application/Presentation/Pages/Dashboard/DashboardPage.dart';
import 'package:order_application/Presentation/Pages/MarketDetails/MarketDetailsScreen.dart';
import 'package:order_application/Presentation/Pages/Onboarding/OnboardingScreen.dart';
import 'package:order_application/Presentation/Pages/Profile/AboutScreen.dart';
import 'package:order_application/Presentation/Pages/Profile/Addresses/AddAddressScreen.dart';
import 'package:order_application/Presentation/Pages/Profile/Addresses/AddressesScreen.dart';
import 'package:order_application/Presentation/Pages/Profile/LanguageScreen.dart';
import 'package:order_application/Presentation/Pages/Profile/MyFavoritesScreen.dart';
import 'package:order_application/Presentation/Pages/Registration/EnterPhoneNumberScreen.dart';
import 'package:order_application/Presentation/Pages/Registration/FillDataScreen.dart';
import 'package:order_application/Presentation/Pages/Registration/VerificationScreen.dart';
import 'package:order_application/Presentation/Pages/Splash/SplashScreen.dart';
import '../../Presentation/Pages/ProductDetails/ProductDetailsScreen.dart';
import '../../Presentation/Pages/Profile/EditInformationScreen.dart';
import '../../Presentation/Pages/Profile/Payment/NewCardScreen.dart';
import '../../Presentation/Pages/Profile/Payment/PaymentMethodsScreen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: '/Onboarding', page: () => OnboardingScreen()),
    GetPage(
        name: '/EnterNumber',
        page: () => EnterNumberScreen(),
        binding: AuthBinding()),
    GetPage(
      name: '/Verification',
      page: () => VerificationScreen(),
    ),
    GetPage(
      name: '/FillData',
      page: () => FillDataScreen(),
    ),
    GetPage(
      name: '/DashboardPage',
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
        name: '/EditInformation',
        page: () => EditInformationScreen(),
        binding: DashboardBinding()),
    GetPage(
        name: '/EnterNumber',
        page: () => EnterNumberScreen(),
        binding: AuthBinding()),
    GetPage(
      name: '/Verification',
      page: () => VerificationScreen(),
    ),
    GetPage(
      name: '/FillData',
      page: () => FillDataScreen(),
    ),
    GetPage(
      name: '/DashboardPage',
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(name: '/EditInformation', page: () => EditInformationScreen()),
    GetPage(name: '/Language', page: () => LanguageScreen()),
    GetPage(name: '/About', page: () => AboutScreen()),
    GetPage(name: '/ProductDetails', page: () => ProductDetailsScreen()),
    GetPage(name: '/Payment', page: () => PaymentMethodsScreen()),
    GetPage(name: '/Addresses', page: () => AddressesScreen()),
    GetPage(name: '/AddAddress', page: () => AddAddressScreen()),
    GetPage(name: '/Details', page: () => ProductDetailsScreen()),
    GetPage(
      name: '/Payment',
      page: () => PaymentMethodsScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: '/NewCard',
      page: () => NewCardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: '/Addresses',
      page: () => AddressesScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(name: '/Favorites', page: () => MyFavoritesScreen()),
    GetPage(name: '/MarketDetails', page: () => MarketDetailsScreen()),
  ];
}
