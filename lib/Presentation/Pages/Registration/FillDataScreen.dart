import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomTextField.dart';
import 'package:order_application/Presentation/Widgets/GetLocationButton.dart';
import 'package:order_application/Presentation/Widgets/OrangeButtonWidget.dart';
import 'package:order_application/Presentation/Widgets/ProfileImagePicker.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';

// Main widget for fill data
class FillDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '',),
      body: Stack(
        children: [
          // Content of the screen
          Padding(
            padding: EdgeInsets.fromLTRB(18.0.w, 0, 18.0.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ProfileImagePicker(),
                ),
                SizedBox(height: 20.h),
                SectionTitle(
                  text: "fill information:".tr,
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                    controller: TextEditingController(),
                    hintText: "first name".tr,
                    keyboardType: TextInputType.name,
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  controller: TextEditingController(),
                  hintText: "last name".tr,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 20.h),
                SectionTitle(
                  text: "location".tr,
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  controller: TextEditingController(),
                  hintText: "location name".tr,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 30.h),
                GetLocationButton(),
              ],
            ),
          ),
          // Positioned Orange Button at the bottom
          Positioned(
            bottom: 40.h,
            right: 24.w,
            child: OrangeButtonWidget(
              function: () {
                Get.toNamed('/DashboardPage');
              },
            ),
          ),
        ],
      ),
    );
  }
}
