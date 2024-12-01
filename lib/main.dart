import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_application/App/Routes/AppRoutes.dart';
import 'package:order_application/App/Translations/AppTranslations.dart';
import 'package:order_application/Presentation/Controllers/Splash/SplashBindings.dart';
import 'package:order_application/Presentation/Pages/Onboarding/OnboardingScreen.dart';
import 'package:order_application/Presentation/Pages/Splash/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          translations: AppTranslations(),
          locale: Locale('en', 'US'),
          fallbackLocale: Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          initialBinding: SplashBindings(),
          getPages: AppRoutes.routes,
          initialRoute: '/',
          home: OnboardingScreen(),
        );
      },
    );
  }
}