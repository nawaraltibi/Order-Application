import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Dashboard/DashboardController.dart';
import 'package:order_application/Presentation/Controllers/Profile/ProfileController.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';

class ProfileScreen extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'.tr,controller:Get.find<DashboardController>(),),
      body: Container(
        child: Center(
          child: Text(
            "Profile",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
