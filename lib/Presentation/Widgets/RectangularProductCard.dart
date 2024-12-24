import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:order_application/Presentation/Widgets/ToggleFavoriteButton.dart';
import '../../App/Color/Color.dart';
import '../../App/Styles/AppTextStyles.dart';

class ProductCard extends StatelessWidget {
  final bool imageType; // false for Svg and true for others
  final String productImage;
  final String productName;
  final double rating;
  final int reviews;
  final double price;

  ProductCard({
    required this.imageType,
    required this.productImage,
    required this.productName,
    required this.rating,
    required this.reviews,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isRTL = Get.locale?.languageCode == 'ar';

    return InkWell(
      onTap: (){
        Get.toNamed('/ProductDetails');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12.withOpacity(0.1), blurRadius: 5),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 73.w,
              height: 90.h,
              child: imageType
                  ? Image.asset(
                      productImage,
                      fit: BoxFit.contain,
                    )
                  : SvgPicture.asset(
                      productImage,
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
                      productName,
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
                  SizedBox(height: 20.h),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '$price',
                          style: AppTextStyles.language.copyWith(
                            color: AppColors.primary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        WidgetSpan(
                          child: Transform.translate(
                            offset: const Offset(2, -5),
                            child: Text(
                              '\$',
                              style: AppTextStyles.language.copyWith(
                                color: AppColors.primary,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ToggleFavoriteButton(
                  onChanged: (bool) {},
                  height: 22.h,
                  width: 22.w,
                ),
                SizedBox(height: 19.h),
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
