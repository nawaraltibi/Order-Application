import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Auth/AuthController.dart';
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
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          isLocationFetched = false;
          isLoading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return;
      }

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
