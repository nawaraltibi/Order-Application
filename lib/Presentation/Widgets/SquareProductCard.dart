
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../App/Styles/AppTextStyles.dart';
import '../../App/Utils/GetPath.dart';
import '../../Data/Models/Product.dart';
import 'DynamicImage.dart';
import 'OrangePriceText.dart';
import 'ToggleFavoriteButton.dart';

class SquareProductCard extends StatelessWidget {
  final Product product;

  const SquareProductCard({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed('/ProductDetails', arguments: product);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 17.35.w, vertical: 5.h),
        width: 153.w,
        height: 205.h,
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
            SizedBox(height: 10.h,),
            Stack(
              children: [
                Center(
                  child:
                  SizedBox(
                    width: 90.w,
                    height: 90.h,
                    child: dynamicImage(imagePath: getProductPath(product)),
                  ),
                ),
                Positioned(
                  right: 0.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                          '${product.rate}',
                          style: AppTextStyles.language.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF8E8EA9)),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h,),
            Text(
              product.name!,
              style: AppTextStyles.language.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: Color(0xFF32324D),
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            SizedBox(height: 7.h,),
            Row(
              children: [
                OrangePriceText(price: product.price, size: 15),
                Spacer(),
                buildToggleFavoriteButton(
                  product: product,
                  height: 22.h,
                  width: 22.w,
                ),
              ],
            ),
            SizedBox(height: 7.h,),
          ],
        ),
      ),
    );
  }
}
