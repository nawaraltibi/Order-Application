import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/CustomTextField.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'addresses'.tr,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 400.h,
              color: Colors.grey[300],
            ),
            SizedBox(
              height: 40.h,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 33.w),
              child: CustomTextField(controller: TextEditingController(),
                hintText: 'location_name'.tr,
              ),
            ),
            SizedBox(height: 25.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 33.w),
              child: CustomBlackButton(buttonText: 'add'.tr, onPressed: (){}),
            ),

          ],
        )
      ),
    );
  }
}
