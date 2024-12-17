import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomOTPField.dart';
import 'package:order_application/Presentation/Widgets/DescriptionText.dart';
import 'package:order_application/Presentation/Widgets/CircularOrangeButton.dart';
import 'package:order_application/Presentation/Widgets/WelcomeText.dart';

// Main widget for entering OTP
class VerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: Stack(
        children: [
          // Content of the screen
          Padding(
            padding: EdgeInsets.fromLTRB(18.0.w, 0, 18.0.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                WelcomeText(),
                SizedBox(height: 10.h),
                DescriptionText(
                  text: 'verification code'.tr,
                ),
                SizedBox(height: 50.h),
                CustomOTPField(
                  controller: TextEditingController(),
                  keyboard: TextInputType.number,
                ),
              ],
            ),
          ),
          // Positioned Orange Button at the bottom
          Positioned(
            bottom: 40.h,
            right: 24.w,
            child: OrangeButtonWidget(
              function: () {
                Get.toNamed("/FillData");
              },
            ),
          ),
        ],
      ),
    );
  }
}
