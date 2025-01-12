import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../App/Color/Color.dart';
import '../../App/Styles/AppTextStyles.dart';
import 'OrangePriceText.dart';

class ShoppingCartContainer extends StatelessWidget {
  final bool isShow;
  final int price;

  ShoppingCartContainer({
    required this.isShow,
    required this.price,
    super.key,
  });

  final RxDouble _opacity = 1.0.obs;

  bool get isRTL => Get.locale?.languageCode == 'ar';

  @override
  Widget build(BuildContext context) {
    if (!isShow) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () => Get.toNamed('/Cart'),
      onTapDown: (_) => _opacity.value = 0.7,
      onTapUp: (_) => _opacity.value = 1.0,
      onTapCancel: () => _opacity.value = 1.0,
      child: Obx(
            () => AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: _opacity.value,
          child: Container(
            margin: EdgeInsets.only(bottom: 20.h),
            padding: EdgeInsets.all(16.w),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.dark,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart,color: Colors.white,size: 30.w,),
                SizedBox(width: 10.w,),
                Expanded(
                  child: Text(
                    'There is a shopping cart available for'.tr,
                    style: AppTextStyles.language.copyWith(
                      height: 1.6,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                OrangePriceText(price: price, size: 14),
              ],
            ),
          ),
        ),
      ),
    );
  }
}