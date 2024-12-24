import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Profile/ProfileController.dart';
import 'package:order_application/Presentation/Controllers/User/UserController.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CircularOrangeButton.dart';
import 'package:order_application/Presentation/Widgets/ProfileImagePicker.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';
import '../../Widgets/CustomTextField.dart';

class EditInformationScreen extends GetView<ProfileController> {
  const EditInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.firstNameController =TextEditingController(text:Get.find<UserController>().user.value.firstName);
    controller.lastNameController =TextEditingController(text:Get.find<UserController>().user.value.lastName);

    return Scaffold(
      appBar: CustomAppBar(title: '',),
      body: Stack(
        children: [
          // Content of the screen
          Padding(
            padding: EdgeInsets.fromLTRB(18.0.w, 0, 18.0.w, 0),
            child: ListView(
              children: [
                Center(
                  child: ProfileImagePicker(imagePath: Get.find<UserController>().user.value.imageName,),
                ),
                SizedBox(height: 20.h),
                SectionTitle(
                  text: "edit information".tr,
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
              ],
            ),
          ),
          // Positioned Orange Button at the bottom
          Positioned(
            bottom: 40.h,
            right: 24.w,
            child: orangeButtonWidget(
              function: () async {
                controller.editUserData();
              }, isLoading: controller.loadingMap['editUserData']!.value,
            ),
          ),
        ],
      ),
    );
  }
}
