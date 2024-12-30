import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Data/Models/Location.dart';
import 'package:order_application/Presentation/Controllers/Cart/CartController.dart';
import 'package:order_application/Presentation/Widgets/BlackPriceText.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/CustomOrangeButton.dart';
import 'package:order_application/Presentation/Widgets/OrangePriceText.dart';
import 'package:order_application/Presentation/Widgets/ProductCardForCart.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';
import 'package:order_application/Presentation/Widgets/SwipeToDeleteWidget.dart';
import '../../Widgets/PlaceOrCardText.dart';

class CartScreen extends StatelessWidget {
  final CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Cart'.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAttentionBox(),
              SizedBox(height: 30.h),
              SectionTitle(text: 'What has been determined:'.tr),
              SizedBox(height: 15.h),
              _buildProductList(),
              SizedBox(height: 20.h),
              _buildDeliveryAddressBox(),
              SizedBox(height: 20.h),
              _buildPriceSummary(),
              SizedBox(height: 25.h),
              CustomBlackButton(buttonText: 'Buy'.tr, onPressed: () {}),
              SizedBox(height: 20.h),
              CustomOrangebButton(buttonText: 'Cancel'.tr, onPressed: () {}),
              SizedBox(height: 40.h),
            ],
          ),
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
                  'Confirm or cancel your cart before\nexiting the application.'
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
    return Column(
      children: [
        for (var product in controller.currentCart.value.products ?? [])
          Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: SwipeToDeleteWidget(
              height: 120,
              child: productCardForCart(
                 product,
              ),
              onSwipe: () {
                return controller.removeProduct(product.id);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildDeliveryAddressBox() {
    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 18.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Delivery address'.tr,
                  style: AppTextStyles.language.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8E8EA9),
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: controller.toggleExpanded,
                  icon: Icon(
                    controller.isExpanded.value
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.primary,
                    size: 23.sp,
                  ),
                ),
              ],
            ),
            if (controller.isExpanded.value)
              controller.currentCart.value.location != null
                  ? _buildLocationDetails()
                  : PlaceOrCardText(
                isPlace: true,
                isAdd: true,
              ),
          ],
        ),
      );
    });
  }

  Widget _buildLocationDetails() {

    return Obx(() {
      Location? location = controller.currentCart.value.location;

      return Column(
        children: [
          if (location != null)
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
                    location.name,
                    style: AppTextStyles.language.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF263238),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    location.region ?? 'City',
                    style: AppTextStyles.language.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF8E8EA9),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    location.street ?? 'Street',
                    style: AppTextStyles.language.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF8E8EA9),
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.only(left: 10.w, top: 15.h),
            child: PlaceOrCardText(
              isAdd: false,
              isPlace: true,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildPriceSummary() {
    return Obx(() {
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
                BlackPriceText(price: controller.currentCart.value.totalCost!.toInt() - controller.currentCart.value.deliveryFee!.toInt(), size: 14),
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
                BlackPriceText(price: controller.currentCart.value.deliveryFee!.toInt(), size: 14),
              ],
            ),
            Divider(
              thickness: 1.5,
              color: Color(0xFFEAEAEF),
            ),
            controller.currentCart.value.card != null
                ? _buildCardDetails()
                : Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.w),
                    child: PlaceOrCardText(
                      isAdd: true,
                      isPlace: false,
                    ),
                  ),
            Divider(
              thickness: 1.5,
              color: Color(0xFFEAEAEF),
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
                OrangePriceText(price: controller.currentCart.value.totalCost!.toInt(), size: 16),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildCardDetails() {
    return Obx(() {
      final card = controller.currentCart.value.card;

      if (card == null) {
        return Center(
          child: Text(
            'No card available'.tr,
            style: AppTextStyles.language.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFF8E8EA9),
            ),
          ),
        );
      }

      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.h, bottom: 5.h),
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Color(0xFFEAEAEF),
                width: 1,
              ),
            ),
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/icons/Credit-Card.svg',
                width: 24.w,
                height: 24.h,
              ),
              title: Text(
                card.name,
                style: AppTextStyles.language.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8E8EA9),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.w),
            child: PlaceOrCardText(
              isAdd: false,
              isPlace: false,
            ),
          ),
        ],
      );
    });
  }
}
