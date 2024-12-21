import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Auth/AuthController.dart';
import 'package:order_application/Presentation/Widgets/RichTextButton.dart';

class ResendCodeWidget extends StatelessWidget {
  final AuthController authController;

  const ResendCodeWidget({Key? key, required this.authController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Obx(() => RichTextButton(
        normalText: !authController.isResendDisabled.value
            ? 'didnt_receive_code'.tr
            : 'resend_code_in'.tr,
        coloredText: authController.isResendDisabled.value
            ? ' ${authController.remainingTime.value}'
            : authController.loadingMap["resend_verification_code"]!.value?? false
            ? 'processing'.tr
            : 'resend'.tr,
        onPressed: authController.isResendDisabled.value ||
            (authController.loadingMap["resend_verification_code"]!.value?? false)
            ? null
            : () {
          authController.resend();
        },
      )),
    );
  }
}
