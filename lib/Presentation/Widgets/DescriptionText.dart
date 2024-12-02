import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';

class DescriptionText extends StatelessWidget {
  final String text;

  const DescriptionText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.language.copyWith(
        fontSize: 16.sp,
        color: Color(0xFF8E8EA9),
        fontWeight: FontWeight.w500,
      ),
      maxLines: null,
      overflow: TextOverflow.visible,
    );
  }
}
