import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:order_application/Presentation/Controllers/Driver/DriverController.dart';
import 'package:order_application/Presentation/Widgets/CustomOrangeButton.dart';
import '../../../App/Color/Color.dart';
import '../../../App/Styles/AppTextStyles.dart';
import '../../../App/Utils/GetPath.dart';
import '../../../Data/Models/Market.dart';
import '../../../Data/Models/Order.dart';
import '../../../Data/Models/Product.dart';
import '../../Widgets/BlackPriceText.dart';
import '../../Widgets/DynamicImage.dart';
import '../../Widgets/OrangePriceText.dart';

class DriverOrderTakenScreen extends GetView<DriverController> {
  const DriverOrderTakenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                controller.getActiveOrder();
              },
            ),
          ],
        ),
        body: Obx(() {
          if (controller.loadingMap['getActiveOrder']!.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
                child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 10.h),
                    height: 500.h,
                    width: 340.w,
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: LatLng(
                          controller.driver.value.location!.latitude,
                          controller.driver.value.location!.longitude,
                        ),
                        initialZoom: 15,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayer(
                          markers: controller.routePoints.map((point) {
                            return Marker(
                              point: point,
                              child: Icon(
                                Icons.location_on_rounded,
                                color: Colors.red,
                                size: 40.w,
                              ),
                            );
                          }).toList(),
                        ),
                        PolylineLayer(
                          polylines: [
                            Polyline(
                              points: controller.routePoints,
                              color: Colors.blue,
                              strokeWidth: 30.0,
                            ),
                          ],
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                  ),
                  child: Obx(() {
                    return buildOrderItem(controller.selectedOrder.value!);
                  }),
                ),
              ],
            ));
          }
        }));
  }

  Widget buildOrderItem(Order order) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildOrdersList(order),
          buildTotalPrice(order),
          CustomOrangebButton(
            buttonText: 'Done'.tr,
            onPressed: () {
              controller.deliverAnOrder();
            },
          ),
        ],
      ),
    );
  }

  ListView buildOrdersList(Order order) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: order.markets!.length,
      itemBuilder: (context, index) {
        final market = order.markets![index];
        return Column(
          children: [
            buildMarketContainer(market),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: const Divider(
                color: Color(0xFFEAEAEF),
                thickness: 2,
              ),
            ),
            buildProductsList(market),
            const Divider(
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
      physics: const NeverScrollableScrollPhysics(),
      itemCount: market.products!.length,
      itemBuilder: (context, index) {
        final product = market.products![index];
        return _buildProductItem(product);
      },
    );
  }

  Column _buildProductItem(Product product) {
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
            const Spacer(),
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
        color: const Color(0xFF32324D),
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
        color: const Color(0xFFA5A5BA),
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
              const Icon(
                Icons.location_pin,
                color: Colors.white,
                size: 18,
              ),
              SizedBox(
                width: 10.w,
              ),
              SizedBox(
                width: 250.w,
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
              )
            ],
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
              color: const Color(0xFF4A4A6A),
            ),
          ),
          const Spacer(),
          OrangePriceText(price: order.totalCost, size: 16),
        ],
      ),
    );
  }
}
