import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Pages/Cart/CartScreen.dart';

import '../../App/Color/Color.dart';
import '../../App/Styles/AppTextStyles.dart';
import 'OrangePriceText.dart';

class ShoppingCartContainer extends StatelessWidget {
  bool isShow;
  int price;

  ShoppingCartContainer({
    required this.isShow,
    required this.price,
    super.key,
  });

  var _opacity = 1.0.obs;
  bool isRTL = Get.locale?.languageCode == 'ar';

  @override
  Widget build(BuildContext context) {
    if (isShow) {
      return GestureDetector(
        onTap: () {
          Get.toNamed('/Cart');
        },
        onTapDown: (_) => _opacity.value = 0.7,
        onTapUp: (_) => _opacity.value = 1.0,
        onTapCancel: () => _opacity.value = 1.0,
        child: Obx(() => AnimatedOpacity(
          duration: Duration(milliseconds: 200),
          opacity: _opacity.value,
          child: Container(
            margin: EdgeInsets.only(bottom: 20.h),
            width: 327.w,
            height: 145.h,
            decoration: BoxDecoration(
              color: AppColors.dark,
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Here it is'.tr,
                        style: AppTextStyles.language.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFA5A5BA),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text('There is a shopping\ncart available for'.tr,
                          style: AppTextStyles.language.copyWith(
                            height: 1.5.h,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: OrangePriceText(price: price, size: 16),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 30.w,
                ),
                SizedBox(
                  height: 145.h,
                  width: 141.w,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(isRTL ? 3.1416 : 0),
                    child: Image.asset(
                      'assets/images/shopping-bag.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      );
    }
    return SizedBox(
      height: 0,
      width: 0,
    );
  }
}