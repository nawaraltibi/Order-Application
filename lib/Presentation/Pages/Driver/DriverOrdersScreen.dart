import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Data/Models/EmptyState.dart';
import 'package:order_application/Data/Models/Market.dart';
import 'package:order_application/Presentation/Controllers/Driver/DriverController.dart';
import 'package:order_application/Presentation/Widgets/CustomOrangeButton.dart';
import 'package:order_application/Presentation/Widgets/EmptyStateWidget.dart';
import 'package:order_application/Presentation/Widgets/OrangePriceText.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';
import '../../../App/Color/Color.dart';
import '../../../App/Utils/GetPath.dart';
import '../../../Data/Models/Order.dart';
import '../../../Data/Models/Product.dart';
import '../../Widgets/BlackPriceText.dart';
import '../../Widgets/CustomAlertDialog.dart';
import '../../Widgets/DynamicImage.dart';

class DriverOrdersScreen extends GetView<DriverController> {
  const DriverOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.language_rounded),
          onPressed: () {
            if (Get.locale?.languageCode == 'en') {
              Get.updateLocale(const Locale('ar'));
            } else {
              Get.updateLocale(const Locale('en'));
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              controller.getUnTakenOrders();
            },
          ),
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CustomAlertDialog(
                    message: 'are you sure you want to log out?'.tr,
                    onConfirm: () {
                      controller.logoutDriver();
                    },
                    onCancel: () {
                      Get.back();
                    },
                    confirmText: 'logout'.tr,
                    cancelText: 'cancel'.tr,
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Obx(() {
          if (controller.loadingMap['getUnTakenOrders']!.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Column(children: [
                SizedBox(height: 50.h),
                SectionTitle(text: "Orders that need to be delivered:".tr),
                SizedBox(height: 20.h),
                controller.orders.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.orders.length,
                        itemBuilder: (context, index) {
                          final order = controller.orders[index];
                          return buildOrderItem(order, index);
                        },
                      )
                    : buildIsEmpty(),
              ]),
            );
          }
        }),
      ),
    );
  }

  Widget buildOrderItem(Order order, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildOrderDate(order),
              Spacer(),
              buildArrowIcon(order),
            ],
          ),
          AnimatedSize(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: order.expanded
                  ? Column(
                      children: [
                        buildOrdersList(order),
                        buildAddressDetails(order),
                        buildTotalPrice(order),
                        CustomOrangebButton(
                            buttonText: 'Take it'.tr,
                            onPressed: () {
                              controller.takeAnOrder(order);
                            }),
                      ],
                    )
                  : Container()),
        ],
      ),
    );
  }

  IconButton buildArrowIcon(Order order) {
    return IconButton(
      onPressed: () {
        controller.updateExpanded(order);
      },
      icon: Icon(
        order.expanded
            ? Icons.keyboard_arrow_up
            : Icons.keyboard_arrow_down_rounded,
        color: AppColors.primary,
        size: 20.sp,
      ),
    );
  }

  Text _buildOrderDate(Order order) {
    return Text(
      'request_on'.trParams({
        'day': order.createdAt!.day.toString(),
        'month': order.createdAt!.month.toString(),
        'year': order.createdAt!.year.toString(),
      }),
      style: AppTextStyles.language.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: Color(0xFF8E8EA9),
      ),
    );
  }

  Container buildIsEmpty() {
    return Container(
        height: 600.h,
        child: EmptyStateWidget(
          state: EmptyState.noOrdersU,
        ));
  }

  ListView buildOrdersList(Order order) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: order.markets!.length,
      itemBuilder: (context, index) {
        final market = order.markets![index];
        return Column(
          children: [
            buildMarketContainer(market),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Divider(
                color: Color(0xFFEAEAEF),
                thickness: 2,
              ),
            ),
            buildProductsList(market),
            Divider(
              color: Color(0xFFEAEAEF),
              thickness: 2,
            ),
          ],
        );
      },
    );
  }

  ListView buildProductsList(Market market) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: market.products!.length,
      itemBuilder: (context, index) {
        final product = market.products![index];
        return _buildProductItem(product);
      },
    );
  }

  Column _buildProductItem(
    Product product,
  ) {
    return Column(
      children: [
        Row(
          children: [
            _buildProductImage(product),
            SizedBox(width: 20.w),
            SizedBox(
              width: 150.w,
              child: _buildProductName(product),
            ),
            Spacer(),
            _buildProductPrice(product),
            _buildProductQuantity(product),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }

  SizedBox _buildProductImage(Product product) {
    return SizedBox(
      width: 32.w,
      height: 40.h,
      child: dynamicImage(imagePath: getProductPath(product)),
    );
  }

  Text _buildProductName(Product product) {
    return Text(
      product.name.toString(),
      style: AppTextStyles.language.copyWith(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: Color(0xFF32324D),
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  BlackPriceText _buildProductPrice(Product product) {
    return BlackPriceText(
      price: product.price,
      size: 14,
    );
  }

  Text _buildProductQuantity(Product product) {
    return Text(
      Get.locale?.languageCode == 'ar'
          ? '  ${product.existingQuantityInOrder}x'
          : ' x ${product.existingQuantityInOrder}',
      style: AppTextStyles.language.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: Color(0xFFA5A5BA),
      ),
    );
  }

  Container buildMarketContainer(Market market) {
    return Container(
        margin: EdgeInsets.only(top: 15.h),
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' ${market.name}',
              style: AppTextStyles.language.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
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
                SizedBox(
                  width: 10.w,
                ),
                SizedBox(
                  width: 200.w,
                  child: Text(
                    '${market.address?.region} , ${market.address?.street}',
                    style: AppTextStyles.language.copyWith(
                      color: Colors.white,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,

                  ),
                ),
              ],
            )
          ],
        ));
  }

  Container buildAddressDetails(Order order) {
    return Container(
      width: 300.w,
      margin: EdgeInsets.only(top: 10.h, bottom: 5.h),
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            order.location!.region ?? 'City',
            style: AppTextStyles.language.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF8E8EA9),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            order.location!.street ?? 'Street',
            style: AppTextStyles.language.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF8E8EA9),
            ),
          ),
        ],
      ),
    );
  }

  Container buildTotalPrice(Order order) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Total price'.tr,
            style: AppTextStyles.language.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4A4A6A)),
          ),
          Spacer(),
          OrangePriceText(price: order.totalCost, size: 16)
        ],
      ),
    );
  }
}
