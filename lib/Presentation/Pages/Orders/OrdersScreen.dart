import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Dashboard/DashboardController.dart';
import 'package:order_application/Presentation/Controllers/Orders/OrdersController.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';

class OrdersScreen extends GetView<OrdersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Orders'.tr, controller:Get.find<DashboardController>(),),
      body: Container(
        child: Center(
          child: Text(
            "Orders",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
