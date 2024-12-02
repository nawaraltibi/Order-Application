import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';

// Widget for the "Welcome!" text
class WelcomeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "welcome".tr,
      style: AppTextStyles.language.copyWith(
        fontSize: 32.sp,
        color: Color(0xff32324D),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
