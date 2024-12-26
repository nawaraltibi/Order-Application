import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/RectangularProductCard.dart';
import 'package:order_application/Presentation/Widgets/SearchField.dart';

import '../../../App/Color/Color.dart';
import '../../../App/Styles/AppTextStyles.dart';

class MyFavoritesScreen extends StatefulWidget {
  bool isRTL = Get.locale?.languageCode == 'ar';

  MyFavoritesScreen({super.key});

  @override
  State<MyFavoritesScreen> createState() => _MyFavoritesScreenState();
}

class _MyFavoritesScreenState extends State<MyFavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'favorites'.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              width: 327.w,
              height: 184.h,
              decoration: BoxDecoration(
                color: AppColors.dark,
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 50.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('For your comfort'.tr,
                            style: AppTextStyles.language.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFA5A5BA))),
                        SizedBox(height: 4.h,),
                        Text('Get your special\nitems in one place.'.tr,
                            style: AppTextStyles.language.copyWith(
                              height: 1.5.h,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),

                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(widget.isRTL ? 3.1416 : 0),
                    child: Image.asset(
                      'assets/images/badge.png',
                      height: 184.h,
                      width: 138.w,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h,),
            SearchField(onSearchChanged: (val){}, onSortSelected: (val) =>{} ,),
            SizedBox(
              height: 30.h,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index){
                return Padding(
                  padding:  EdgeInsets.only(bottom: 25.h),
                  child: RectangularProductCard(
                      imageType: true,
                      productImage: 'assets/images/mobile.jpg',
                      productName: 'Samsung Galaxy A35',
                      rating: 4.9,
                      reviews: 120,
                      price: 270
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
