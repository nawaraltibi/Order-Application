import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';

// Widget for the SectionTitle text
class SectionTitle extends StatelessWidget {

  final String text;

  const SectionTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.language.copyWith(
        fontSize: 20.sp,
        color: Color(0xff32324D),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
