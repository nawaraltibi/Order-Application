import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/CustomOrangeButton.dart';

class CustomAlertDialog extends StatelessWidget {
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomAlertDialog({
    Key? key,
    required this.message,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.w),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyles.language
            .copyWith(fontSize: 17.sp, fontWeight: FontWeight.w500),
      ),
      actions: [
        CustomOrangebButton(
          buttonText: confirmText,
          onPressed: onConfirm,
        ),
        SizedBox(height: 16.h),
        CustomBlackButton(
          buttonText: cancelText,
          onPressed: onCancel,
        ),
      ],
    );
  }
}
