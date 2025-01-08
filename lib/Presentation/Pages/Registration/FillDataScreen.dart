import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Auth/AuthController.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomTextField.dart';
import 'package:order_application/Presentation/Widgets/GetLocationButton.dart';
import 'package:order_application/Presentation/Widgets/CircularOrangeButton.dart';
import 'package:order_application/Presentation/Widgets/ProfileImagePicker.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';

// Main widget for fill data
class FillDataScreen extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
      ),
      body: Stack(
        children: [
          // Content of the screen
          Padding(
            padding: EdgeInsets.fromLTRB(18.0.w, 0, 18.0.w, 0),
            child: ListView(
              children: [
                Center(
                  child: ProfileImagePicker(imagePath: '1734953968Screenshot 2023-12-04 210507.png',),
                ),
                SizedBox(height: 20.h),
                SectionTitle(
                  text: "fill information:".tr,
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  controller: controller.firstNameController,
                  hintText: "first name".tr,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  controller: controller.lastNameController,
                  hintText: "last name".tr,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 20.h),
                SectionTitle(
                  text: "location".tr,
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  controller: controller.addressController,
                  hintText: "location name".tr,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 30.h),
                GetLocationButton(
                    onLocationFetched: (Position position){
                      Get.find<AuthController>().updateLocation(position.latitude, position.longitude);
                    }
                ),
              ],
            ),
          ),
          // Positioned Orange Button at the bottom
          Positioned(
            bottom: 40.h,
            right: 24.w,
            child: Obx(() => orangeButtonWidget(
                  function: () async {
                    controller.fillUserData();
                  },
                  isLoading: controller.loadingMap['fill_data']!.value,
                )),
          ),
        ],
      ),
    );
  }
}
