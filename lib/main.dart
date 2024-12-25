import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_application/App/Routes/AppRoutes.dart';
import 'package:order_application/App/Theme/Theme.dart';
import 'package:order_application/App/Translations/AppTranslations.dart';
import 'package:order_application/Presentation/Controllers/Dashboard/DashboardBinding.dart';
import 'package:order_application/Presentation/Controllers/Language/LanguageController.dart';
import 'package:order_application/Presentation/Controllers/SharedPreferences/SharedPreferencesController.dart';
import 'package:order_application/Presentation/Controllers/Splash/SplashBindings.dart';
import 'package:order_application/Presentation/Controllers/User/UserController.dart';
import 'package:order_application/Presentation/Pages/Dashboard/DashboardPage.dart';
import 'package:order_application/Presentation/Pages/Splash/SplashScreen.dart';

import 'Data/Repository/user_repository.dart';
import 'Domain/Usecases/user_usecases/GetAuthenticatedUserUseCase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(SharedPreferencesController());
  final LanguageController languageController = Get.put(LanguageController());
  await languageController.loadLanguage();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Obx(() {

          final LanguageController languageController = Get.find<LanguageController>();
          return GetMaterialApp(
            theme: AppTheme.lightTheme,
            translations: AppTranslations(),
            locale: languageController.currentLocale.value,
            fallbackLocale: const Locale('en', 'US'),
            debugShowCheckedModeBanner: false,
            initialBinding: SplashBindings(),
            getPages: AppRoutes.routes,
            initialRoute: '/',
            home: SplashScreen(),
          );
        });
      },
    );
  }
}