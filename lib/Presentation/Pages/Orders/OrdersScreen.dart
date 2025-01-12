import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Data/Models/Order.dart';
import 'package:order_application/Data/Models/OrderStatus.dart';
import 'package:order_application/Data/Models/Product.dart';
import 'package:order_application/Presentation/Controllers/Orders/OrdersController.dart';
import 'package:order_application/Presentation/Widgets/BlackPriceText.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/OrangePriceText.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';
import '../../../App/Utils/GetPath.dart';
import '../../../Data/Models/EmptyState.dart';
import '../../Controllers/Dashboard/DashboardController.dart';
import '../../Widgets/DynamicImage.dart';
import '../../Widgets/EmptyStateWidget.dart';

class OrdersScreen extends GetView<OrdersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() {
        return _buildBody(context, controller.orderItems);
      }),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: 'Orders'.tr,
      controller: Get.find<DashboardController>(),
      trailingWidget: IconButton(
        onPressed: () {
          controller.fetchAllOrders();
        },
        icon: Icon(Icons.refresh, color: AppColors.dark),
      ),
    );
  }

  Widget _buildBody(BuildContext context, List<Order> orders) {
    final isLoading = controller.loadingMap["fetchAllOrders"]?.value ?? false;

    if (isLoading) {
      return _buildLoading();
    }

    if (orders.isEmpty) {
      return Center(
        child: EmptyStateWidget(
          state: EmptyState.noOrdersU,
        ),
      );
    }

    return _buildOrdersList(context, orders);
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildOrdersList(BuildContext context, List<Order> orders) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      children: [
        SectionTitle(text: 'submitted_requests'.tr),
        SizedBox(height: 20.h),
        Column(
          children: _buildOrderItems(context, orders),
        ),
        SizedBox(height: 50.h),
      ],
    );
  }

  List<Widget> _buildOrderItems(BuildContext context, List orders) {
    return orders.asMap().entries.map((entry) {
      final index = entry.key;
      final order = entry.value;
      return _buildOrderCard(context, index, order);
    }).toList();
  }

  Widget _buildOrderCard(BuildContext context, int index, Order order) {
    final statusDetails = order.status;

    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderHeader(index, order, statusDetails),
          _buildOrderDetails(context, index, order, statusDetails),
        ],
      ),
    );
  }

  Row _buildOrderHeader(int index, Order order, OrderStatus statusDetails) {
    return Row(
      children: [
        _buildStatusIndicator(statusDetails),
        SizedBox(width: 10.w),
        _buildOrderDate(order),
        Spacer(),
        _buildExpandButton(order),
      ],
    );
  }

  Container _buildStatusIndicator(OrderStatus statusDetails) {
    Color statusColor;
    if (statusDetails == OrderStatus.pendingConfirmation) {
      statusColor = Color(0xFFF19434);
    } else if (statusDetails == OrderStatus.inDelivery) {
      statusColor = Color(0xFFFCC737);
    } else {
      statusColor = Color(0xFF3E7B27);
    }

    return Container(
      height: 18.h,
      width: 18.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: statusColor,
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

  IconButton _buildExpandButton(Order order) {
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

  Widget _buildOrderDetails(
      BuildContext context, int index, Order order, OrderStatus statusDetails) {
    return AnimatedSize(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: order.expanded
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                _buildStatusText(statusDetails),
                SizedBox(
                  height: 20.h,
                ),
                _buildDivider(10, 10),
                SizedBox(
                  height: 20.h,
                ),
                _buildProductsList(order.products!, statusDetails),
                SizedBox(
                  height: 20.h,
                ),
                _buildDivider(0, 10),
                SizedBox(
                  height: 20.h,
                ),
                _buildOrderSummary(order),
                SizedBox(
                  height: 20.h,
                ),
                if (order.isEditable()) _buildEditableOptions(context, order),
              ],
            )
          : Container(),
    );
  }

  Text _buildStatusText(OrderStatus statusDetails) {
    String statusText;
    if (statusDetails == OrderStatus.pendingConfirmation) {
      statusText = 'wait_confirmation'.tr;
    } else if (statusDetails == OrderStatus.inDelivery) {
      statusText = 'on_way'.tr;
    } else {
      statusText = 'Delivered'.tr;
    }

    return Text(
      statusText,
      style: AppTextStyles.language.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: Color(0xFF4A4A6A),
      ),
    );
  }

  Divider _buildDivider(double top, double bottom) {
    return Divider(
      height: 0,
      thickness: 1,
      color: Color(0xFFEAEAEA),
      indent: top,
      endIndent: bottom,
    );
  }

  ListView _buildProductsList(
      List<Product> products, OrderStatus statusDetails) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        controller.initializeRatings(products.length);
        return _buildProductItem(index, products[index], statusDetails);
      },
    );
  }

  Column _buildProductItem(
      int index, Product product, OrderStatus statusDetails) {
    return Column(
      children: [
        Row(
          children: [
            _buildProductImage(product),
            SizedBox(width: 20.w),
            SizedBox(width: 150.w,child: _buildProductName(product),),
            Spacer(),
            _buildProductPrice(product),
            _buildProductQuantity(product),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        if (statusDetails == OrderStatus.delivered) _buildRatingStars(index,product),
        if (statusDetails == OrderStatus.delivered)
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

  Row _buildRatingStars(int productIndex,Product product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (index) {
        return InkWell(
          onTap: ()  async{
            controller.updateStars(productIndex, index,product);
            controller.productRatings.refresh();
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

  Row _buildOrderSummary(Order order) {
    return Row(
      children: [
        Text(
          'Total price'.tr,
          style: AppTextStyles.language.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
            color: Color(0xFF4A4A6A),
          ),
        ),
        Spacer(),
        OrangePriceText(
          price: order.totalCost,
          size: 16,
        ),
      ],
    );
  }

  Column _buildEditableOptions(BuildContext context, Order order) {
    return Column(children: [
      _buildDivider(10, 10),
      SizedBox(
        height: 20.h,
      ),
      _buildLocationTile(order),
      SizedBox(
        height: 20.h,
      ),
      _buildDivider(10, 10),
      SizedBox(
        height: 20.h,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: InkWell(
          onTap: () {
            controller.goToEditOrderPage(
              order,
            );
          },
          borderRadius: BorderRadius.circular(16.r),
          child: Row(
            children: [
              Icon(
                Icons.edit,
                color: AppColors.primary,
                size: 22.sp,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                ' edit_order'.tr,
                style: AppTextStyles.language.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 15.h,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: InkWell(
          onTap: () {
            controller.showDeleteRequestDialog(context, order);
          },
          borderRadius: BorderRadius.circular(16.r),
          child: Row(
            children: [
              Icon(
                Icons.delete,
                color: Color(0xFFCD1F45),
                size: 22.sp,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                ' delete_request'.tr,
                style: AppTextStyles.language.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFCD1F45)),
              ),
            ],
          ),
        ),
      )
    ]);
  }

  Container _buildLocationTile(Order order) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Color(0xFFEAEAEF),
          width: 1,
        ),
      ),
      child: ListTile(
        leading: Icon(
          Icons.location_on_sharp,
          color: Color(0xFF8E8EA9),
          size: 24.sp,
        ),
        title: Text(
          order.location!.name,
          style: AppTextStyles.language.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
