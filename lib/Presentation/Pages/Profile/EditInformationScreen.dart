import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CircularOrangeButton.dart';
import 'package:order_application/Presentation/Widgets/ProfileImagePicker.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';
import '../../Widgets/CustomTextField.dart';

class EditInformationScreen extends StatelessWidget {
  const EditInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.w),
        child: Column(
          children: [
            const ProfileImagePicker(),
            SizedBox(
              height: 33.h,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: SectionTitle(text: "Edit your information:".tr)),
            SizedBox(
              height: 17.h,
            ),
            CustomTextField(
              controller: TextEditingController(),
              hintText: "First name".tr,
              keyboardType: TextInputType.name,
            ),
            SizedBox(
              height: 23.h,
            ),
            CustomTextField(
              controller: TextEditingController(),
              hintText: "Last name".tr,
              keyboardType: TextInputType.name,
            ),
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 220.h,
                    left: 260.w,
                    child: OrangeButtonWidget(function: () {}),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
