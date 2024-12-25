import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../App/Color/Color.dart';
import '../../App/Styles/AppTextStyles.dart';

class MarketCard extends StatelessWidget {
  final bool imageType; // false for Svg and true for others
  final String marketImage;
  final String marketName;
  final double rating;
  final int reviews;

  MarketCard({
    required this.imageType,
    required this.marketImage,
    required this.marketName,
    required this.rating,
    required this.reviews,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isRTL = Get.locale?.languageCode == 'ar';

    return InkWell(
      onTap: () {
        String lastRoute = Get.previousRoute;
        if(lastRoute!='/MarketDetails')Get.toNamed('/MarketDetails');
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12.withOpacity(0.1), blurRadius: 5),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 73.w,
              height: 92.h,
              child: imageType
                  ? Image.asset(
                      marketImage,
                      fit: BoxFit.contain,
                    )
                  : SvgPicture.asset(
                      marketImage,
                      fit: BoxFit.contain,
                    ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      marketName,
                      style: AppTextStyles.language.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                      maxLines: 2,
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
                        "$rating",
                        style: AppTextStyles.language.copyWith(
                          color: const Color(0xFF8E8EA9),
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "review".trParams({'num': reviews.toString()}),
                        style: AppTextStyles.language.copyWith(
                          color: const Color(0xFFC0C0CF),
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 22.w,
                    height: 22.h,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(isRTL ? 3.1416 : 0),
                      child: SvgPicture.asset(
                        'assets/icons/arrow-right-card.svg',
                        width: 12.h,
                        height: 12.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
