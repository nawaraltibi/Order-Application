import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';

class GetLocationButton extends StatefulWidget {
  final void Function(Position)? onLocationFetched;

  const GetLocationButton({
    Key? key,
    this.onLocationFetched,
  }) : super(key: key);

  @override
  _GetLocationButtonState createState() => _GetLocationButtonState();
}

class _GetLocationButtonState extends State<GetLocationButton> {
  bool isLocationFetched = false;
  bool isLoading = false;

  Future<void> _fetchLocation(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      // التحقق من تمكين خدمات الموقع
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          isLocationFetched = false;
          isLoading = false;
        });
        Get.snackbar(
          "Location Services Disabled",
          "Please enable location services to continue.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // التحقق من الأذونات
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            isLoading = false;
          });
          Get.snackbar(
            "Permission Denied",
            "Location permission is required to fetch your location.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange,
            colorText: Colors.white,
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          isLoading = false;
        });
        Get.snackbar(
          "Permission Permanently Denied",
          "You need to enable location permission from settings.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // الحصول على الموقع
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      if (widget.onLocationFetched != null) {
        widget.onLocationFetched!(position);
      }

      setState(() {
        isLocationFetched = true;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLocationFetched = false;
        isLoading = false;
      });
      Get.snackbar(
        "Error",
        "An error occurred while fetching location: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLocationFetched
          ? Icon(Icons.check_circle_outline_outlined, color: Colors.teal, size: 40.w)
          : CustomBlackButton(
        buttonText: "get location".tr,
        onPressed: isLoading ? null : () => _fetchLocation(context),
        isLoading: isLoading,
      ),
    );
  }
}
