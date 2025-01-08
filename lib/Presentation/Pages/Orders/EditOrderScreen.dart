import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Data/Models/Order.dart';
import 'package:order_application/Presentation/Controllers/Orders/OrdersController.dart';
import 'package:order_application/Presentation/Widgets/BlackPriceText.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/CustomOrangeButton.dart';
import 'package:order_application/Presentation/Widgets/OrangePriceText.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';
import 'package:order_application/Presentation/Widgets/SwipeToDeleteWidget.dart';
import '../../Widgets/PlaceSelector.dart';
import '../../Widgets/ProductCardForOrder.dart';

class EditOrderScreen extends GetView<OrdersController> {

  @override
  Widget build(BuildContext context) {
    controller.selectedOrder.value = Get.arguments as Order;
    return Scaffold(
      appBar: CustomAppBar(title: 'Cart'.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Obx((){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAttentionBox(),
                SizedBox(height: 30.h),
                SectionTitle(text: 'What has been determined:'.tr),
                SizedBox(height: 15.h),
                _buildProductList(),
                SizedBox(height: 10.h),
                _buildDeliveryAddressBox(),
                SizedBox(height: 20.h),
                _buildPriceSummary(),
                SizedBox(height: 25.h),
                CustomBlackButton(buttonText: 'Buy'.tr, onPressed: () {controller.editOrder(controller.selectedOrder.value!);}),
                SizedBox(height: 20.h),
                CustomOrangebButton(buttonText: 'Cancel'.tr, onPressed: () {}),
                SizedBox(height: 40.h),
              ],
            );
          })
        ),
      ),
    );
  }

  Widget _buildAttentionBox() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: Get.locale?.languageCode == 'ar' ? 210.w : -17.w,
            top: -15.h,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(
                  Get.locale?.languageCode == 'ar' ? 3.1416 : 0),
              child: SvgPicture.asset(
                'assets/images/two-white-circles.svg',
                width: 141.w,
                height: 145.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'attention'.tr,
                  style: AppTextStyles.language.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA5A5BA),
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  'You cannot increase the quantity'
                      .tr,
                  style: AppTextStyles.language.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    final products = controller.selectedOrder.value?.products ?? [];
    return Column(
      children: [
        for (var product in products)
          Padding(
            key: ValueKey(product.id),
            padding: EdgeInsets.only(bottom: 20.h),
            child: SwipeToDeleteWidget(
              height: 130,
              child: productCardForOrder(
                product,
              ),
              onSwipe: () async {
                bool success = await controller.removeProduct(product.id);
                return success;
              },
            ),
          ),
      ],
    );
  }

  Widget _buildDeliveryAddressBox() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 18.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                'Delivery address'.tr,
                style: AppTextStyles.language.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8E8EA9),
                ),
              ),
            ),
            SizedBox(height: 10.h,),
            _buildLocationDetails()
          ],
        ),
      );
  }

  Widget _buildLocationDetails() {
      return Column(
        children: [
            Container(
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
                    controller.selectedOrder.value!.location!.name,
                    style: AppTextStyles.language.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF263238),
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.only(left: 10.w, top: 15.h),
            child: PlaceSelector(),
          ),
        ],
      );
  }

  Widget _buildPriceSummary() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Price of products'.tr,
                  style: AppTextStyles.language.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF666687),
                  ),
                ),
                Spacer(),
                BlackPriceText(price: controller.selectedOrder.value!.totalCost! - controller.selectedOrder.value!.deliveryFee!.toInt(), size: 14),
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Text(
                  'Delivery'.tr,
                  style: AppTextStyles.language.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF666687),
                  ),
                ),
                Spacer(),
                BlackPriceText(price: controller.selectedOrder.value!.deliveryFee, size: 14),
              ],
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 10.h),
              child: Divider(
                thickness: 1.5,
                color: Color(0xFFEAEAEF),
              ),
            ),
            Row(
              children: [
                Text(
                  'Total price'.tr,
                  style: AppTextStyles.language.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4A4A6A),
                  ),
                ),
                Spacer(),
                OrangePriceText(price: controller.selectedOrder.value!.totalCost, size: 16),
              ],
            ),
          ],
        ),
      );
  }
}