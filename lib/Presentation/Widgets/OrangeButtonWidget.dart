import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OrangeButtonWidget extends StatelessWidget {
  // Add a function parameter
  final VoidCallback function;

  // Constructor to accept the function parameter
  const OrangeButtonWidget({
    super.key,
    required this.function, // Make onPressed required
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56.w,
      height: 56.h,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFF19434),
            elevation: 2,
            padding: EdgeInsets.all(0)
        ),
        child: SvgPicture.asset(
          'assets/images/arrow-right.svg',
          width: 24.89.w,
          height: 24.89.h,
        ),
      ),
    );
  }
}