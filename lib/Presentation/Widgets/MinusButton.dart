import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MinusButton extends StatelessWidget {
  VoidCallback onTap;

  MinusButton({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.grey,
        backgroundColor: const Color(0xFFEAEAEF),
        elevation: 0,
        padding: EdgeInsets.only(bottom: 12.h),
        shape: CircleBorder(),
      ),
      child: Icon(
        Icons.minimize_rounded,
        color: const Color(0xFF292D32),
        size: 20.sp,
      ),
    );
  }
}