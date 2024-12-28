
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../App/Styles/AppTextStyles.dart';
import 'OrangePriceText.dart';
import 'ToggleFavoriteButton.dart';

class SquareProductCard extends StatelessWidget {
  String productImage;
  String productName;
  int price;
  double rating;
  SquareProductCard({
    required this.productImage,
    required this.productName,
    required this.price,
    required this.rating,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed('ProductDetails');
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 17.35.w, vertical: 13.5.h),
        width: 153.w,
        height: 193.h,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(17.35.r),
            boxShadow: [
              BoxShadow(
                color: Color(0x1A434343),
                offset: Offset(0, 4.h),
                blurRadius: 10.r,
                spreadRadius: 2.r,
              ),
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    child: Image.asset(
                      productImage,
                      width: 75,
                      height: 91.h,
                      fit: BoxFit.contain,
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                ),
                Positioned(
                  left: 77.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    width: 46.35.w,
                    height: 21.69.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13.r),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x1A434343),
                              offset: Offset(0, 0.h),
                              blurRadius: 5.r,
                              spreadRadius: 3.r
                          ),
                        ]
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Color(0xFFFFB01D),
                          size: 15,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          '$rating',
                          style: AppTextStyles.language.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF8E8EA9)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h,),
            Text(
              productName,
              style: AppTextStyles.language.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: Color(0xFF32324D),
              ),
            ),
            SizedBox(height: 7.h,),
            Row(
              children: [
                OrangePriceText(price: price, size: 15),
                Spacer(),
                ToggleFavoriteButton(onChanged: (val){}, height: 24, width: 24)
              ],
            )
          ],
        ),
      ),
    );
  }
}
