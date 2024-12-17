import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  var currentLocale = const Locale('en', 'US').obs;

  static const String languageKey = 'selectedLanguage';

  @override
  void onInit() {
    super.onInit();
    loadLanguage();
  }

  Future<void> changeLanguage(String languageCode, String countryCode) async {
    Locale locale = Locale(languageCode, countryCode);
    currentLocale.value = locale;

    Get.updateLocale(locale);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, languageCode);
    await prefs.setString('countryCode', countryCode);
  }

  Future<void> loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString(languageKey);
    String? countryCode = prefs.getString('countryCode');

    if (languageCode != null && countryCode != null) {
      Locale locale = Locale(languageCode, countryCode);
      currentLocale.value = locale;
      Get.updateLocale(locale);
    }
  }
}
