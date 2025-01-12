import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Driver/DriverController.dart';

import '../../../Data/Models/EmptyState.dart';
import '../../Widgets/CustomAlertDialog.dart';
import '../../Widgets/EmptyStateWidget.dart';
import '../../Widgets/GetLocationButton.dart';

class GetCurrentLocationScreen extends GetView<DriverController> {
  const GetCurrentLocationScreen({super.key});

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
      body: Column(
        children: [
          Expanded(child: EmptyStateWidget(state: EmptyState.noOrdersD)),
          Padding(
            padding: EdgeInsets.only(bottom: 40.h),
            child: GetLocationButton(
                onLocationFetched: (Position position){
                  Get.find<DriverController>().updateLocation(position.latitude, position.longitude);
                  controller.getActiveOrder();
                }
            ),
          ),
        ],
      ),
    );
  }
}