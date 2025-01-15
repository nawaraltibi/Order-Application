import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Presentation/Controllers/Cart/CartController.dart';
import 'package:order_application/Presentation/Controllers/Home/HomeController.dart';
import 'package:order_application/Presentation/Controllers/User/UserController.dart';
import '../../../App/Utils/GetPath.dart';
import '../../Widgets/DynamicImage.dart';
import '../../Widgets/SectionTitle.dart';
import '../../Widgets/ShoppingCartContainer.dart';
import '../../Widgets/buildHorizontalList.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(18.0.w, 0, 18.0.w, 0),
        child: ListView(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 60.h,
              ),
              Obx(() {
                return Row(
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: dynamicImage(imagePath: getUserPath(), box: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      width: 19.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Get.find<UserController>().user.value.name ?? "Guest",
                          style: AppTextStyles.language.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          'need'.tr,
                          style: AppTextStyles.language.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: Colors.grey[500],
                          ),
                        )
                      ],
                    ),
                  ],
                );
              }),
              SizedBox(
                height: 30.h,
              ),
              Obx(() {
                return ShoppingCartContainer(
                  isShow: !Get.find<CartController>().isCartEmpty(),
                  price: Get.find<CartController>()
                      .currentCart
                      .value
                      .totalCost!
                      .toInt(),
                );
              }),
            ]),
            SizedBox(height: 20.h),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 280.w, child: SectionTitle(text: 'you might like'.trParams({
                    'category': controller.category,
                  })),),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      controller.getForYouProducts();
                    },
                  ),
                ],
              );
            }),
            SizedBox(height: 10.h),
            Obx(() {
              return buildHorizontalList(
                isLoading: controller.loadingMap['getForYouProducts']!.value,
                hasError: controller.errorMap['getForYouProducts'],
                items: controller.forYou,
                onRetry: controller.getForYouProducts,
              );
            }),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SectionTitle(text: 'Best-Selling:'.tr),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    controller.getBestSellingProducts();
                  },
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Obx(() {
              return buildHorizontalList(
                isLoading: controller.loadingMap['getBestSellingProducts']!.value,
                hasError: controller.errorMap['getBestSellingProducts'],
                items: controller.bestSelling,
                onRetry: controller.getBestSellingProducts,
              );
            }),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SectionTitle(text: 'Top-Rated:'.tr),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    controller.getTopRatedProducts();
                  },
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Obx(() {
              return buildHorizontalList(
                isLoading: controller.loadingMap['getTopRatedProducts']!.value,
                hasError: controller.errorMap['getTopRatedProducts'],
                items: controller.topRated,
                onRetry: controller.getTopRatedProducts,
              );
            }),
            SizedBox(height: 20.h),

          ],
        ),
      ),
    );
  }
}
