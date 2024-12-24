import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomOTPField.dart';
import 'package:order_application/Presentation/Widgets/DescriptionText.dart';
import 'package:order_application/Presentation/Widgets/CircularOrangeButton.dart';
import 'package:order_application/Presentation/Widgets/ResendCodeWidget.dart';
import 'package:order_application/Presentation/Controllers/Auth/AuthController.dart';
import 'package:order_application/Presentation/Widgets/WelcomeText.dart';

// Main widget for entering OTP
class VerificationScreen extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    controller.otpController = TextEditingController();
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
                  controller: controller.otpController,
                  keyboard: TextInputType.number,
                ),
                SizedBox(height: 20.h),
                buildResendCodeWidget(
                  authController: controller,
                ),
              ],
            ),
          ),
          // Positioned Orange Button at the bottom
          Positioned(
            bottom: 40.h,
            right: 24.w,
            child: Obx(
              () => orangeButtonWidget(
                function: () async {
                  controller.verify();
                },
                isLoading: controller.loadingMap['verify']!.value,
              ),
            ),
          )
        ],
      ),
    );
  }
}
