import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../App/Color/Color.dart';
import '../../App/Styles/AppTextStyles.dart';

class NormalText extends StatelessWidget {
  final String text;
  final int size;
  const NormalText({
    required this.text,
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      """$text""".tr,
      style: AppTextStyles.language.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: size.sp,
          color: AppColors.dark,
      ),
    );
  }
}