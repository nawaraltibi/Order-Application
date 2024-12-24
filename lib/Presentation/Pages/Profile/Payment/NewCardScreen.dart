import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/CustomTextField.dart';
import 'package:order_application/Presentation/Controllers/Profile/ProfileController.dart';
import '../../../Widgets/CustomAppBar.dart';

class NewCardScreen extends GetView<ProfileController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'payment'.tr,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.w),
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 2,
                        blurRadius: 5)
                  ], borderRadius: BorderRadius.circular(10.r)),
                  child: SvgPicture.asset(
                    'assets/icons/big-card.svg',
                    height: 210.h,
                    fit: BoxFit.contain,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 90.h), // Add padding if needed
                    child: Obx(() => FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        controller.cardNumber.value,
                        style: AppTextStyles.language.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 20.sp,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )),
                  ),
                ),
                Positioned(
                  left: 39.w,
                  top: 150.h,
                  child: Obx(() => buildText(controller.cardName.value, 15)),
                ),
                Positioned(
                  left: 185.w,
                  top: 150.h,
                  child: Obx(() => buildText(controller.expiryDate.value, 15)),
                ),
              ],
            ),
            SizedBox(height: 40.h),
            CustomTextField(
              hintText: 'Card number'.tr,
              controller: controller.cardNumberController,
              keyboardType: TextInputType.number,
              suffixIcon: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                ),
                child: SvgPicture.asset(
                  "assets/icons/two-circles.svg",
                  width: 32.w,
                  height: 23.h,
                ),
              ),
              onChanged: (value) {
                controller.cardNumber.value = value.isEmpty? 'XXXX XXXX XXXX XXXX': value;
              },
            ),
            SizedBox(height: 25.h),
            CustomTextField(
              hintText: 'Name on card'.tr,
              controller: controller.nameOnCardController,
              keyboardType: TextInputType.name,
              onChanged: (value) {
                controller.cardName.value = value.isEmpty? 'Name on card'.tr: value;
              },
            ),
            SizedBox(height: 25.h),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: 'Expiry date'.tr,
                    controller: controller.expiryDateController,
                    keyboardType: TextInputType.datetime,
                    onChanged: (value) {
                      controller.expiryDate.value = value.isEmpty? 'Expiry date'.tr: value;
                    },
                  ),
                ),
                SizedBox(width: 30.w),
                Expanded(
                  child: CustomTextField(
                    hintText: 'CVC',
                    controller: controller.cvcController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 35.h,
            ),
            CustomBlackButton(
                buttonText: 'Register'.tr,
                onPressed: () {
                  controller.createAnCards();
                })
          ],
        ),
      ),
    );
  }

  Text buildText(String text, int size) {
    return Text(
      '$text'.tr,
      style: AppTextStyles.language.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: size.sp,
        color: Colors.white,
      ),
    );
  }
}
