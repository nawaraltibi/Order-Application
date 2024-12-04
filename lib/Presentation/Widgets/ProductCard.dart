import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../App/Color/Color.dart';
import '../../App/Styles/AppTextStyles.dart';

class ProductCard extends StatelessWidget {
  bool imageType; // false for Svg and true others
  String productImage;
  String productName;
  double rating;
  int reviews;
  double price;

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
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12.withOpacity(0.1), blurRadius: 5)
          ]),
      child: Row(
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
          SizedBox(
            width: 12.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$productName".tr,
                style: AppTextStyles.language
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_half,
                    color: Color(0xFFFFB01D),
                    size: 19.sp,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    "$rating",
                    style: AppTextStyles.language.copyWith(
                      color: Color(0xFF8E8EA9),
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    "($reviews review)".tr,
                    style: AppTextStyles.language.copyWith(
                      color: Color(0xFFC0C0CF),
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 8.w,
                  ),
                  Text.rich(TextSpan(
                    children: [
                      TextSpan(
                        text: '$price', // Base
                        style: AppTextStyles.language.copyWith(
                            color: AppColors.primary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      WidgetSpan(
                        child: Transform.translate(
                          offset: const Offset(2, -5),
                          // Adjust position for superscript
                          child: Text(
                            '\$', // Exponent
                            style: AppTextStyles.language.copyWith(
                                color: AppColors.primary,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 50.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: 26.w,
                  height: 26.h,
                  child: FittedBox(
                    fit: BoxFit.none,
                    child: SvgPicture.asset(
                      "assets/images/icons/favorite.svg",
                      width: 50.w,
                      height: 50.h,
                    ),
                  ),
                  decoration: BoxDecoration(
                      // color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0.5,
                          blurRadius: 5,
                          blurStyle: BlurStyle.outer,
                        )
                      ]),
                ),
              ),
              SizedBox(
                height: 19.h,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 26.w,
                  height: 26.h,
                  child: FittedBox(
                    fit: BoxFit.none,
                    child: SvgPicture.asset(
                      "assets/images/icons/arrow-right-card.svg",
                      width: 22.w,
                      height: 22.h,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
