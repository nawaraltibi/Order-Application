import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:order_application/App/Const/Host.dart';
import 'package:order_application/Data/Models/Market.dart';
import '../../App/Color/Color.dart';
import '../../App/Styles/AppTextStyles.dart';
import '../../App/Utils/GetPath.dart';
import 'DynamicImage.dart';

class MarketCard extends StatelessWidget {
  final Market market;

  const MarketCard({
    required this.market,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isRTL = Get.locale?.languageCode == 'ar';

    return InkWell(
      onTap: () {
        Get.toNamed('/MarketDetails', arguments: market);
      },
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
            // Market Logo
            SizedBox(
              width: 73.w,
              height: 92.h,
              child: dynamicImage(imagePath: getMarketPath(market)),
            ),
            SizedBox(width: 12.w),
            // Market Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Market Name
                  Text(
                    market.name,
                    style: AppTextStyles.language.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  // Rating and Reviews
                  Row(
                    children: [
                      Icon(
                        Icons.star_half,
                        color: AppColors.primary,
                        size: 19.sp,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        "${market.rate}",
                        style: AppTextStyles.language.copyWith(
                          color: const Color(0xFF8E8EA9),
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "review".trParams({'num': market.rateCount.toString()}),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed('/MarketDetails', arguments: market);
                  },
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
