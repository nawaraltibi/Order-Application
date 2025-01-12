import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/Data/Models/Product.dart';
import 'package:order_application/Presentation/Controllers/Orders/OrdersController.dart';
import 'package:order_application/Presentation/Widgets/OrangePriceText.dart';
import 'package:order_application/Presentation/Widgets/MinusButton.dart';
import 'package:order_application/Presentation/Widgets/PlusButton.dart';
import '../../App/Color/Color.dart';
import '../../App/Styles/AppTextStyles.dart';
import '../../App/Utils/GetPath.dart';
import 'DynamicImage.dart';

Widget productCardForOrder(Product product) {
  final OrdersController ordersController = Get.find();

  return InkWell(
    borderRadius: BorderRadius.circular(16),
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16.r),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Image with Loading Indicator
          SizedBox(
            width: 73.w,
            height: 90.h,
            child: dynamicImage(imagePath: getProductPath(product)),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    product.name ?? '',
                    style: AppTextStyles.language.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.star_half,
                      color: AppColors.primary,
                      size: 19.sp,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      "${product.rate ?? 0.0}",
                      style: AppTextStyles.language.copyWith(
                        color: const Color(0xFF8E8EA9),
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "review".trParams({'num': product.totalSold
                          .toString()}),
                      style: AppTextStyles.language.copyWith(
                        color: const Color(0xFFC0C0CF),
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.h),
                OrangePriceText(price: product.price ?? 0, size: 16),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.h,
                width: 40.w,
                child: PlusButton(onTap: () {
                  // Increase quantity using CartController
                  ordersController.incrementProductQuantity(product.id!);
                }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Text(
                  '${ordersController.getProductQuantity(product.id!).value}',
                  style: AppTextStyles.language.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF666687),
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
                width: 40.w,
                child: MinusButton(onTap: () {
                  // Decrease quantity using CartController
                  ordersController.decrementProductQuantity(product.id!);
                }),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}