import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Data/Models/OrderStatus.dart';
import 'package:order_application/Presentation/Controllers/Orders/OrdersController.dart';
import 'package:order_application/Presentation/Widgets/BlackPriceText.dart';
import 'package:order_application/Presentation/Widgets/CustomAlertDialog.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/OrangePriceText.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';
import '../../Controllers/Dashboard/DashboardController.dart';

class OrdersScreen extends GetView<OrdersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Orders'.tr,
          controller: Get.find<DashboardController>(),
        ),
        body: GetBuilder<OrdersController>(
            builder: (controller) => SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitle(text: 'submitted_requests'.tr),
                        SizedBox(
                          height: 20.h,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              controller.initializeExpanded(2);

                              return Obx(() {
                                Color statusColor;
                                if (controller.testOrder.status ==
                                    OrderStatus.pendingConfirmation) {
                                  statusColor = Color(0xFFF19434);
                                } else if (controller.testOrder.status ==
                                    OrderStatus.inDelivery) {
                                  statusColor = Color(0xFFFCC737);
                                } else {
                                  statusColor = Color(0xFF3E7B27);
                                }

                                String statusText;
                                if (controller.testOrder.status ==
                                    OrderStatus.pendingConfirmation) {
                                  statusText = 'wait_confirmation'.tr;
                                } else if (controller.testOrder.status ==
                                    OrderStatus.inDelivery) {
                                  statusText = 'on_way'.tr;
                                } else {
                                  statusText = 'Delivered'.tr;
                                }

                                return Container(
                                  margin: EdgeInsets.only(bottom: 20.h),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.h, horizontal: 15.w),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 18.h,
                                            width: 18.w,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: statusColor),
                                          ),
                                          SizedBox(width: 10.w),
                                          Text(
                                            'request_on'.trParams({
                                              'day': controller
                                                  .testOrder.createdAt!.day
                                                  .toString(),
                                              'month': controller
                                                  .testOrder.createdAt!.month
                                                  .toString(),
                                              'year': controller
                                                  .testOrder.createdAt!.year
                                                  .toString(),
                                            }),
                                            style:
                                                AppTextStyles.language.copyWith(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF8E8EA9),
                                            ),
                                          ),
                                          Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              controller.updateExpanded(index);
                                            },
                                            icon: Icon(
                                              controller.expandedOrders[index]
                                                  ? Icons.keyboard_arrow_up
                                                  : Icons
                                                      .keyboard_arrow_down_rounded,
                                              color: AppColors.primary,
                                              size: 20.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      AnimatedSize(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                          child:
                                              controller.expandedOrders[index]
                                                  ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(height: 15.h),
                                                        Text(
                                                          statusText,
                                                          style: AppTextStyles
                                                              .language
                                                              .copyWith(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Color(
                                                                0xFF4A4A6A),
                                                          ),
                                                        ),
                                                        buildDivider(10, 10),
                                                        ListView.builder(
                                                          shrinkWrap: true,
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          itemCount: controller
                                                              .testOrder
                                                              .products!
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            controller
                                                                .initializeRatings(
                                                                    controller
                                                                        .testOrder
                                                                        .products!
                                                                        .length);
                                                            return Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          15.h),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        controller
                                                                            .testOrder
                                                                            .products![index]
                                                                            .image
                                                                            .toString(),
                                                                        width:
                                                                            32.w,
                                                                        height:
                                                                            40.h,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              10.w),
                                                                      Text(
                                                                        controller
                                                                            .testOrder
                                                                            .products![index]
                                                                            .name
                                                                            .toString(),
                                                                        style: AppTextStyles
                                                                            .language
                                                                            .copyWith(
                                                                          fontSize:
                                                                              15.sp,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color:
                                                                              Color(0xFF32324D),
                                                                        ),
                                                                      ),
                                                                      Spacer(),
                                                                      BlackPriceText(
                                                                        price: controller
                                                                            .testOrder
                                                                            .products![index]
                                                                            .price,
                                                                        size:
                                                                            14,
                                                                      ),
                                                                      Text(
                                                                        Get.locale?.languageCode ==
                                                                                'ar'
                                                                            ? '  ${controller.testOrder.products![index].quantity}x'
                                                                            : ' x ${controller.testOrder.products![index].quantity}',
                                                                        style: AppTextStyles
                                                                            .language
                                                                            .copyWith(
                                                                          fontSize:
                                                                              14.sp,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          color:
                                                                              Color(0xFFA5A5BA),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  controller
                                                                          .testOrder
                                                                          .isEditable()
                                                                      ? Container()
                                                                      : Padding(
                                                                          padding: EdgeInsets.only(
                                                                              left: 60.w,
                                                                              right: 60.w,
                                                                              top: 10.h),
                                                                          child:
                                                                              ratingStars(index),
                                                                        ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        buildDivider(0, 10),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Total price'.tr,
                                                              style:
                                                                  AppTextStyles
                                                                      .language
                                                                      .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 16.sp,
                                                                color: Color(
                                                                    0xFF4A4A6A),
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            OrangePriceText(
                                                              price: controller
                                                                  .testOrder
                                                                  .totalCost,
                                                              size: 16,
                                                            ),
                                                          ],
                                                        ),
                                                        controller.testOrder
                                                                .isEditable()
                                                            ? Container(
                                                                child: Column(
                                                                  children: [
                                                                    buildDivider(
                                                                        10, 10),
                                                                    Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical: 5
                                                                              .h,
                                                                          horizontal:
                                                                              10.w),
                                                                      width: double
                                                                          .infinity,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.white,
                                                                          borderRadius: BorderRadius.circular(16.r),
                                                                          border: Border.all(
                                                                            color:
                                                                                Color(0xFFEAEAEF),
                                                                            width:
                                                                                1,
                                                                          )),
                                                                      child:
                                                                          ListTile(
                                                                        leading:
                                                                            Icon(
                                                                          Icons
                                                                              .location_on_sharp,
                                                                          color:
                                                                              Color(0xFF8E8EA9),
                                                                          size:
                                                                              24.sp,
                                                                        ),
                                                                        title:
                                                                            Text(
                                                                          controller
                                                                              .testOrder
                                                                              .location!
                                                                              .name,
                                                                          style: AppTextStyles.language.copyWith(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xFF8E8EA9)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                        child:
                                                                            Column(
                                                                      children: [
                                                                        buildDivider(
                                                                            10,
                                                                            10),
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: 10.w),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              controller.goToEditOrderPage(
                                                                                controller.testOrder,
                                                                              );
                                                                            },
                                                                            borderRadius:
                                                                                BorderRadius.circular(16.r),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.edit,
                                                                                  color: AppColors.primary,
                                                                                  size: 22.sp,
                                                                                ),
                                                                                Text(
                                                                                  ' edit_order'.tr,
                                                                                  style: AppTextStyles.language.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.primary),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              15.h,
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: 10.w),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              controller.showDeleteRequestDialog(context);
                                                                            },
                                                                            borderRadius:
                                                                                BorderRadius.circular(16.r),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.delete,
                                                                                  color: Color(0xFFCD1F45),
                                                                                  size: 22.sp,
                                                                                ),
                                                                                Text(
                                                                                  ' delete_request'.tr,
                                                                                  style: AppTextStyles.language.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Color(0xFFCD1F45)),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )),
                                                                  ],
                                                                ),
                                                              )
                                                            : Container()
                                                      ],
                                                    )
                                                  : Container()),
                                    ],
                                  ),
                                );
                              });
                            }),
                        SizedBox(
                          height: 50.h,
                        ),
                        CustomBlackButton(
                            buttonText: 'Change Status',
                            onPressed: () {
                              controller.changeStatue();
                            })
                      ]),
                ))));
  }

  Widget ratingStars(int productIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (index) {
        return InkWell(
          onTap: () {
            controller.updateStars(
                productIndex, index); // Update specific product rating
          },
          child: Obx(() => SvgPicture.asset(
                index < controller.productRatings[productIndex]
                    ? 'assets/icons/filled-star.svg'
                    : 'assets/icons/outlined-star.svg',
                width: 24,
                height: 24,
              )),
        );
      }),
    );
  }
}

Padding buildDivider(int top, int bottom) {
  return Padding(
    padding: EdgeInsets.only(top: top.h, bottom: bottom.h),
    child: Divider(
      color: Color(0xFFEAEAEF),
      thickness: 2,
    ),
  );
}
