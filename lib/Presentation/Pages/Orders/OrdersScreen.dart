import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Presentation/Widgets/AddressCardWidget.dart';
import 'package:order_application/Presentation/Widgets/BlackPriceText.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/CustomOrangeButton.dart';
import 'package:order_application/Presentation/Widgets/OrangePriceText.dart';
import 'package:order_application/Presentation/Widgets/PaymentCardWidget.dart';
import 'package:order_application/Presentation/Widgets/ProductCardForCart.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';
import 'package:order_application/Presentation/Widgets/SwipeToDeleteWidget.dart';
import '../../Controllers/Dashboard/DashboardController.dart';
import '../../Widgets/PlaceOrCardText.dart';

class OrdersScreen extends StatefulWidget {
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // This changes when I press on the arrow in the location container
  bool _isExpanded = false;

  // I get this from PlaceOrCardText Widget, if it is true it will show the location in the container
  bool _isThereLocation = false;

  // Same thing for the card
  bool _isThereCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Orders'.tr,
        controller: Get.find<DashboardController>(),
      ),
      body: Center(
        child: Text(
          'Orders',
          style: AppTextStyles.language.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      )
    );
  }
}
