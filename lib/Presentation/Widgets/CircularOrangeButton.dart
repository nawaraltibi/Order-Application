import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

Widget orangeButtonWidget({
  required Future<void> Function() function, // Asynchronous function to be executed
  required bool isLoading, // Current loading state
}) {
  return SizedBox(
    width: 56.w,
    height: 56.h,
    child: ElevatedButton(
      onPressed: isLoading
          ? null
          : () async {
        await function(); // Execute the provided function
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF19434), // Button's background color
        elevation: 2, // Button elevation for shadow effect
        padding: const EdgeInsets.all(0), // Remove padding inside the button
      ),
      child: isLoading
          ? SizedBox(
        width: 24.w,
        height: 24.h,
        child: const CircularProgressIndicator(
          color: Colors.white, // Color of the spinner
          strokeWidth: 2.0, // Width of the spinner's stroke
        ),
      )
          : SvgPicture.asset(
        'assets/icons/arrow-right.svg', // Icon asset
        width: 24.89.w, // Dynamic width
        height: 24.89.h, // Dynamic height
      ),
    ),
  );
}
