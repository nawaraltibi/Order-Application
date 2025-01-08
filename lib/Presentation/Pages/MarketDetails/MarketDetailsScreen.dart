import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Presentation/Widgets/ReviewsContainer.dart';
import 'package:order_application/Presentation/Widgets/SearchField.dart';
import '../../../App/Const/Host.dart';
import '../../../App/Utils/GetPath.dart';
import '../../../Data/Models/Market.dart';
import '../../Controllers/Market/MarketProductsController.dart';
import '../../Widgets/DynamicImage.dart';
import '../../Widgets/SquareProductCard.dart';

class MarketDetailsScreen extends StatefulWidget {
  const MarketDetailsScreen({super.key});

  @override
  State<MarketDetailsScreen> createState() => _MarketDetailsScreenState();
}

class _MarketDetailsScreenState extends State<MarketDetailsScreen> {
  bool isRTL = Get.locale?.languageCode == 'ar';
  late Market market;
  final MarketProductsController controller =
      Get.find<MarketProductsController>();

  @override
  void initState() {
    super.initState();
    market = Get.arguments;
    controller.setMarketId(market.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.9,
            child: dynamicImage(imagePath: getMarketPath(market)),
          ),
          Container(
            width: 360.w,
            height: 360.h,
            color: Colors.grey.withOpacity(0.5),
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
                  borderRadius: BorderRadius.circular(20.r),
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
                  color: const Color(0xFFF1F1F1F1),
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
                            color: const Color(0xFF323247),
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
                              market.name,
                              style: AppTextStyles.language.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  color: Colors.white,
                                  size: 18.sp,
                                ),
                                Text(
                                  "market.address",
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
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(bottom: 42.h),
                          child: ReviewsContainer(
                              rating: market.rate, reviews: market.rateCount),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  SearchField(
                    onSearchChanged: (val) {
                      controller.onSearchChanged(val);
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    child: Obx(
                      () {
                        if (controller.loadingMap['getMarketProducts']!.value &&
                            controller.products.isEmpty) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (controller.products.isEmpty) {
                          return const Center(
                              child: Text("No products available"));
                        }

                        return NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent &&
                                !(controller.loadingMap['getMarketProducts']
                                        ?.value ??
                                    false)) {
                              controller.getNextProductsPage();
                            }
                            return true;
                          },
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 15.w,
                                    mainAxisSpacing: 15.h,
                                    childAspectRatio:
                                        (ScreenUtil().screenWidth / 2) /
                                            (ScreenUtil().screenHeight * 0.3)),
                            itemCount: controller.products.length + 1,
                            itemBuilder: (context, index) {
                              if (index == controller.products.length) {
                                return Obx(() {
                                  if (controller.meta.value?.currentPage ==
                                          controller.meta.value?.lastPage ||
                                      !(controller
                                              .loadingMap['getMarketProducts']
                                              ?.value ??
                                          false)) {
                                    return const SizedBox.shrink();
                                  }
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.h),
                                    child: const Center(
                                        child: CircularProgressIndicator()),
                                  );
                                });
                              }

                              final product = controller.products[index];
                              return SquareProductCard(
                                product: product,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
