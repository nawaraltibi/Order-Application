import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';

class RichTextButton extends StatelessWidget {
  final String normalText;
  final String coloredText;
  final VoidCallback? onPressed;

  const RichTextButton({
    Key? key,
    required this.normalText,
    required this.coloredText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: RichText(
        text: TextSpan(
          style: AppTextStyles.language.copyWith(
            fontSize: 14.sp,
            color: Color(0xff32324D),
            fontWeight: FontWeight.w500,
          ),
          children: [
            TextSpan(
              text: normalText,
              style: AppTextStyles.language.copyWith(
                fontSize: 14.sp,
                color: AppColors.dark,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: coloredText,
              style: AppTextStyles.language.copyWith(
                fontSize: 14.sp,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
