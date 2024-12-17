import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class AppTextStyles {
  static TextStyle get language {
    return Get.locale?.languageCode == 'ar'
        ? GoogleFonts.almarai()
        : GoogleFonts.mulish();
  }
}
