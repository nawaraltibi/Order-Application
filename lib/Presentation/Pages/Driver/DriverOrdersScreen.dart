import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Data/Models/EmptyState.dart';
import 'package:order_application/Presentation/Controllers/Driver/DriverController.dart';
import 'package:order_application/Presentation/Widgets/CustomOrangeButton.dart';
import 'package:order_application/Presentation/Widgets/EmptyStateWidget.dart';
import 'package:order_application/Presentation/Widgets/GetLocationButton.dart';
import 'package:order_application/Presentation/Widgets/OrangePriceText.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';
import '../../../App/Color/Color.dart';
import '../../Widgets/BlackPriceText.dart';
import '../../Widgets/CustomAlertDialog.dart';

class DriverOrdersScreen extends GetView<DriverController> {
  const DriverOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.language_rounded),
          onPressed: () {
            if (Get.locale?.languageCode == 'en') {
              Get.updateLocale(const Locale('ar'));
            } else {
              Get.updateLocale(const Locale('en'));
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CustomAlertDialog(
                    message: 'are you sure you want to log out?'.tr,
                    onConfirm: () {
                      // controller.logoutUser();
                    },
                    onCancel: () {
                      Get.back();
                    },
                    confirmText: 'logout'.tr,
                    cancelText: 'cancel'.tr,
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: controller.orders.isEmpty
              ? buildIsEmpty()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70.h,
                      ),
                      SectionTitle(text: "Orders that need to be delivered:".tr),
                      buildRequestsList(),
                    ],
                  ),
                )),
    );
  }

  ListView buildRequestsList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          controller.initializeExpanded(3);
          return Obx(() {
            return Container(
              margin: EdgeInsets.only(bottom: 20.h),
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      buildRequestText(),
                      Spacer(),
                      buildArrowIcon(index),
                    ],
                  ),
                  AnimatedSize(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: controller.expandedOrders[index]
                          ? Column(
                              children: [
                                buildOrdersList(),
                                buildAddressDetails(),
                                buildTotalPrice(),
                                CustomOrangebButton(
                                    buttonText: 'Take it'.tr,
                                    onPressed: () {
                                      Get.toNamed('DriverOrderTaken');
                                    }),
                              ],
                            )
                          : Container()),
                ],
              ),
            );
          });
        });
  }

  IconButton buildArrowIcon(int index) {
    return IconButton(
      onPressed: () {
        controller.updateExpanded(index);
      },
      icon: Icon(
        controller.expandedOrders[index]
            ? Icons.keyboard_arrow_up
            : Icons.keyboard_arrow_down_rounded,
        color: AppColors.primary,
        size: 20.sp,
      ),
    );
  }

  Text buildRequestText() {
    return Text(
      Get.locale?.languageCode == 'ar'?'طلب لـ Nawar Al-Tibi':'Request to Nawar Al-Tibi',
      style: AppTextStyles.language.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: Color(0xFF8E8EA9),
      ),
    );
  }

  Column buildIsEmpty() {
    return Column(
      children: [
        Expanded(child: EmptyStateWidget(state: EmptyState.noOrdersD)),
        Padding(
          padding: EdgeInsets.only(bottom: 40.h),
          child: GetLocationButton(
              onLocationFetched: (Position position){
                Get.find<DriverController>().updateLocation(position.latitude, position.longitude);
              }
          ),
        ),
      ],
    );
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

  Container buildAddressDetails() {
    return Container(
      width: 300.w,
      margin: EdgeInsets.only(top: 10.h, bottom: 5.h),
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kafr Sousa' ?? 'City',
            style: AppTextStyles.language.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF8E8EA9),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            'Abdullah Ibn Rawaha Street' ?? 'Street',
            style: AppTextStyles.language.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF8E8EA9),
            ),
          ),
        ],
      ),
    );
  }
}
