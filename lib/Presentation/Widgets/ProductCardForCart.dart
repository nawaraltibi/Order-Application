import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:order_application/Presentation/Widgets/OrangePriceText.dart';
import 'package:order_application/Presentation/Widgets/ToggleFavoriteButton.dart';
import 'package:order_application/Presentation/Widgets/MinusButton.dart';
import 'package:order_application/Presentation/Widgets/PlusButton.dart';
import '../../App/Color/Color.dart';
import '../../App/Styles/AppTextStyles.dart';

class ProductCardForCart extends StatefulWidget {
  final bool imageType; // false for Svg and true for others
  final String productImage;
  final String productName;
  final double rating;
  final int reviews;
  final double price;

  ProductCardForCart({
    required this.imageType,
    required this.productImage,
    required this.productName,
    required this.rating,
    required this.reviews,
    required this.price,
    super.key,
  });

  @override
  State<ProductCardForCart> createState() => _ProductCardForCartState();
}

class _ProductCardForCartState extends State<ProductCardForCart> {
  int num = 0;
  @override
  Widget build(BuildContext context) {
    bool isRTL = Get.locale?.languageCode == 'ar';

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: (){
        Get.toNamed('/ProductDetails');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),

        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80.w,
              height: 96.h,
              child: widget.imageType
                  ? Image.asset(
                widget.productImage,
                fit: BoxFit.contain,
              )
                  : SvgPicture.asset(
                widget.productImage,
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
                      widget.productName,
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
                        "${widget.rating}",
                        style: AppTextStyles.language.copyWith(
                          color: const Color(0xFF8E8EA9),
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "review".trParams({'num': widget.reviews.toString()}),
                        style: AppTextStyles.language.copyWith(
                          color: const Color(0xFFC0C0CF),
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  OrangePriceText(price: 1700, size: 16)
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
                  child: PlusButton(onTap: (){
                    setState(() {
                      num++;
                    });
                  }),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(vertical:4.h),
                  child: Text('$num',style: AppTextStyles.language.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF666687),
                  ),),
                ),
                SizedBox(
                  height: 40.h,
                  width: 40.w,
                  child: MinusButton(onTap: (){
                    setState(() {
                      if(num>0)num--;
                    });
                  }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
