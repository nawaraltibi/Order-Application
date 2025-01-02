import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Driver/DriverController.dart';
import 'package:order_application/Presentation/Widgets/CustomOrangeButton.dart';

import '../../../App/Color/Color.dart';
import '../../../App/Styles/AppTextStyles.dart';
import '../../Widgets/BlackPriceText.dart';
import '../../Widgets/OrangePriceText.dart';

class DriverOrderTakenScreen extends GetView<DriverController> {
  const DriverOrderTakenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 80.h),
              width: double.infinity,
              height: 360.h,
              color: Colors.grey[300],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20.h,
                horizontal: 20.w,
              ),
              child: Column(
                children: [
                  buildOrdersList(),
                  buildTotalPrice(),
                  CustomOrangebButton(buttonText: 'Done'.tr, onPressed: (){}),
                  SizedBox(height: 20.h,)

                ],
              ) ,
            )
          ],
        ),
      ),
    );
  }
}
ListView buildOrdersList() {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: 2,
    itemBuilder: (context, ind) {
      return Column(
        children: [
          buildMarketContainer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Divider(
              color: Color(0xFFEAEAEF),
              thickness: 2,
            ),
          ),
          buildProductsList(),
          Divider(
            color: Color(0xFFEAEAEF),
            thickness: 2,
          ),
        ],
      );
    },
  );
}

ListView buildProductsList() {
  return ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: 3,
    itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.only(bottom: 15.h),
        child: Row(
          children: [
            Image.asset(
              'assets/images/mobile.jpg',
              width: 32.w,
              height: 40.h,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 10.w),
            Text(
              'Samsung Galaxy A35',
              style: AppTextStyles.language.copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF32324D),
              ),
            ),
            Spacer(),
            BlackPriceText(
              price: 2700,
              size: 14,
            ),
            Text(
              Get.locale?.languageCode == 'ar' ? '  2 x' : ' x 2',
              style: AppTextStyles.language.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFFA5A5BA),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Container buildMarketContainer() {
  return Container(
      margin: EdgeInsets.only(top: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' XIAOMI',
                style: AppTextStyles.language.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                  Text(
                    ' Al-Muhajireen , Shamshiya',
                    style: AppTextStyles.language.copyWith(
                      color: Colors.white,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            width: 30.w,
          ),
        ],
      ));
}
Container buildTotalPrice() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 20.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Total price'.tr,
          style: AppTextStyles.language.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Color(0xFF4A4A6A)),
        ),
        Spacer(),
        OrangePriceText(price: 9300, size: 16)
      ],
    ),
  );
}