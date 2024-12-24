import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Auth/AuthController.dart';
import 'package:order_application/Presentation/Widgets/RichTextButton.dart';

Widget buildResendCodeWidget({required AuthController authController}) {
  return Container(
    alignment: Alignment.topCenter,
    child: Obx(() => RichTextButton(
      normalText: authController.isResendDisabled.value
          ? '${'resend_code_in'.tr} ${authController.remainingTime.value}'
          : 'didnt_receive_code'.tr,
      coloredText: authController.isResendDisabled.value
          ? ''
          : authController.loadingMap["resend_verification_code"]!.value
          ? 'processing'.tr
          : 'resend'.tr,
      onPressed: authController.isResendDisabled.value ||
          (authController.loadingMap["resend_verification_code"]!.value)
          ? null
          : () {
        authController.resend();
        authController.startResendTimer();
      },
    )),
  );
}