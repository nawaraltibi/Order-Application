import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:order_application/Presentation/Controllers/Profile/ProfileController.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/CustomTextField.dart';

class AddAddressScreen extends GetView<ProfileController> {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'addresses'.tr,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400.h,
              width: 340.w,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(33.500694, 36.301993),
                  initialZoom: 10,
                  onTap: (tapPosition, LatLng position) {
                    controller.latitude.value = position.latitude;
                    controller.longitude.value = position.longitude;
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  Obx(() => MarkerLayer(
                    markers: [
                        Marker(
                          point: LatLng(controller.latitude.value, controller.longitude.value),
                          child: Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                    ],
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 33.w),
              child: CustomTextField(
                controller: controller.addressNameController,
                hintText: 'location_name'.tr,
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 33.w),
              child: CustomBlackButton(
                  buttonText: 'add'.tr,
                  onPressed: () {
                    controller.createAnAddress();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
