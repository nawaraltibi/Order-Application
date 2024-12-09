import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';

class CustomBlackButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final bool isLoading;

  const CustomBlackButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.dark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        minimumSize: Size(320.w, 50.h),
        padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 30.w),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? CircularProgressIndicator(color: Colors.white)
          : Text(
              buttonText,
              style: AppTextStyles.language.copyWith(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
    );
  }
}
