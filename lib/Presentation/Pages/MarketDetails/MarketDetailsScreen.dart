import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Presentation/Widgets/ReviewsContainer.dart';
import 'package:order_application/Presentation/Widgets/SearchField.dart';
import '../../Controllers/Dashboard/DashboardController.dart';
import '../../Widgets/SquareProductCard.dart';

class MarketDetailsScreen extends StatelessWidget {
  MarketDetailsScreen({super.key});

  bool isRTL = Get.locale?.languageCode == 'ar';
  late final DashboardController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.9,
            child: Container(
              child: Image.asset(
                'assets/images/market.jpg',
                width: 360.w,
                height: 360.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            width: 360.w,
            height: 360.h,
            color: Colors.grey.withOpacity(0.2),
          ),
          Positioned(
            top: 50.h,
            left: 18.w,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 46.w,
                height: 46.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(isRTL ? 3.1416 : 0),
                    child: SvgPicture.asset(
                      'assets/icons/arrow-left.svg',
                      width: 14.h,
                      height: 14.h,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(
                top: 20.h, right: 20.w, left: 20.w, bottom: 10.h),
            margin: EdgeInsets.only(top: 180.h),
            decoration: BoxDecoration(
                color: Color(0xFFF1F1F1F1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36.r),
                    topRight: Radius.circular(36.r))),
            child: Column(
              children: [
                Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                    width: 323.w,
                    height: 105.h,
                    decoration: BoxDecoration(
                        color: AppColors.dark,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF323247),
                            offset: Offset(0, 2.h),
                            blurRadius: 5.r,
                          ),
                        ]),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ' XIAOMI',
                              style: AppTextStyles.language.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  color: Colors.white,
                                  size: 18.sp,
                                ),
                                Text(
                                  ' Al-Muhajireen , Shamshiya',
                                  style: AppTextStyles.language.copyWith(
                                    color: Colors.white,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: 42.h),
                            child: ReviewsContainer(rating: 5.0, reviews: 214)),
                      ],
                    )),
                SizedBox(
                  height: 25.h,
                ),
                SearchField(
                    onSearchChanged: (val) {}, onSortSelected: (val) {}),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.w,
                        mainAxisSpacing: 15.h,
                        childAspectRatio: 0.83),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return SquareProductCard(
                        productImage: 'assets/images/mobile.jpg',
                        productName: 'Galaxy A55',
                        price: 2700,
                        rating: 5.0,
                      );
                    },
                  ),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
