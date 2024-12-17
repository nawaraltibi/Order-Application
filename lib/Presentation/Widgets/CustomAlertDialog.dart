import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/CustomOrangeButton.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.w), // Rounded corners
      ),
      content: Text(
        textAlign: TextAlign.center,
        message,
        style: AppTextStyles.language
            .copyWith(fontSize: 17.sp, fontWeight: FontWeight.w500),
      ),
      actions: [
        CustomOrangebButton(buttonText: 'Logout', onPressed: () {}),
        SizedBox(
          height: 16.h,
        ),
        CustomBlackButton(
            buttonText: 'Cancel',
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );
  }
}
