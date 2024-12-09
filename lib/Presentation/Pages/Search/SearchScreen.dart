import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Dashboard/DashboardController.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';

class SearchScreen extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Search'.tr,controller:Get.find<DashboardController>(),),
      body: Container(
        child: Center(
          child: Text(
            "Search",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
