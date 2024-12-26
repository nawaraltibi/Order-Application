import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Profile/ProfileController.dart';
import 'package:order_application/Presentation/Controllers/User/UserController.dart';
import 'package:order_application/Presentation/Widgets/AddressCardWidget.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';
import 'package:order_application/Presentation/Widgets/SwipeToDeleteWidget.dart';

class AddressesScreen extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    controller.getAllAddress();

    return Scaffold(
      appBar: CustomAppBar(
        title: "addresses".tr,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: SectionTitle(text: 'your_addresses'.tr),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Obx(() {
                final locations = Get.find<UserController>().user.value.locations ?? [];
                final isLoading = controller.loadingMap['getAllAddress']?.value;
                if (isLoading!) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (locations.isEmpty) {
                  return Center(
                    child: Text(
                      "no_addresses".tr,
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    final location = locations[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 25.h),
                      child: SwipeToDeleteWidget(
                        height: 108,
                        child: AddressCardWidget(
                          type: location.name,
                          address: "${location.region ?? ''}",
                          details: "${location.street ?? ''}",
                        ),
                        onSwipe: () {
                          controller.deleteAnAddress(location.id!);
                        },
                      ),
                    );
                  },
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.h),
              child: CustomBlackButton(
                buttonText: 'add'.tr,
                onPressed: () {
                  Get.toNamed('/AddAddress');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
