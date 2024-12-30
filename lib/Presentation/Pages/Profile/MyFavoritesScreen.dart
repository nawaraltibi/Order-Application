import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Data/Models/EmptyState.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/EmptyStateWidget.dart';
import 'package:order_application/Presentation/Widgets/RectangularProductCard.dart';
import 'package:order_application/Presentation/Widgets/SearchField.dart';
import '../../../App/Color/Color.dart';
import 'package:order_application/Presentation/Controllers/Favorites/FavoritesController.dart';

class MyFavoritesScreen extends GetView<FavoriteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'favorites'.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Obx(() {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.showFavorites(page: 1);
            },
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                    !(controller.loadingMap['showFavorites']?.value ?? false)) {
                  controller.getNextSearchPage();
                }
                return true;
              },
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 50.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'For your comfort'.tr,
                                style: AppTextStyles.language.copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFA5A5BA)),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Get your special\nitems in one place.'.tr,
                                style: AppTextStyles.language.copyWith(
                                  height: 1.5.h,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(
                              Get.locale?.languageCode == 'ar' ? 3.1416 : 0),
                          child: Image.asset(
                            'assets/images/badge.png',
                            height: 184.h,
                            width: 138.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      Expanded(
                        child: SearchField(
                          onSearchChanged: (val) {
                            controller.searchFavorites(val);
                          },
                        ),
                      ),
                      SizedBox(width: 10.w),
                      IconButton(
                        onPressed: () async {
                          await controller.showFavorites(page: 1);
                        },
                        icon: Icon(Icons.refresh, color: AppColors.primary),
                        iconSize: 24.sp,
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  controller.searchedProducts.isEmpty
                      ? EmptyStateWidget(
                    state: EmptyState.noFavorites,
                  )
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.searchedProducts.length + 1,
                    itemBuilder: (context, index) {
                      if (index == controller.searchedProducts.length) {
                        return Obx(() {
                          if (controller.meta.value?.currentPage ==
                              controller.meta.value?.lastPage ||
                              !(controller.loadingMap['showFavorites']
                                  ?.value ??
                                  false)) {
                            return SizedBox.shrink();
                          }
                          return Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: 20.h),
                            child:
                            Center(child: CircularProgressIndicator()),
                          );
                        });
                      }

                      final product =
                      controller.searchedProducts[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 25.h),
                        child: RectangularProductCard(
                          product: product,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}