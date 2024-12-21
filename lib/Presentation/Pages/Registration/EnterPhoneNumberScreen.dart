import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Auth/AuthController.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomTextField.dart';
import 'package:order_application/Presentation/Widgets/DescriptionText.dart';
import 'package:order_application/Presentation/Widgets/CircularOrangeButton.dart';
import 'package:order_application/Presentation/Widgets/ToggleRoleButton.dart';
import 'package:order_application/Presentation/Widgets/WelcomeText.dart';

// Main widget for entering number
class EnterNumberScreen extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        trailingWidget: ToggleRoleButton(
          authController: controller,
        ),
      ),
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
                  text: 'enter the number'.tr,
                ),
                SizedBox(height: 50.h),
                CustomTextField(
                  controller: controller.phoneController,
                  hintText: "phone number".tr,
                  keyboardType: TextInputType.phone,
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
                    controller.register();
                  },
                  isLoading: controller.loadingMap['register']!.value,
                ),
              ))
        ],
      ),
    );
  }
}
