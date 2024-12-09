import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';

class GetLocationButton extends StatefulWidget {
  final double? initialLatitude;
  final double? initialLongitude;

  const GetLocationButton({
    Key? key,
    this.initialLatitude,
    this.initialLongitude,
  }) : super(key: key);

  @override
  _GetLocationButtonState createState() => _GetLocationButtonState();
}

class _GetLocationButtonState extends State<GetLocationButton> {
  bool isLocationFetched = false;
  bool isLoading = false;

  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();

    latitude = widget.initialLatitude;
    longitude = widget.initialLongitude;
  }

  Future<void> _fetchLocation(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          latitude = null;
          longitude = null;
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

      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
        isLocationFetched = true;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        latitude = null;
        longitude = null;
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
