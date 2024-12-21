import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/Presentation/Controllers/Auth/AuthController.dart';

class ToggleRoleButton extends StatefulWidget {
  final AuthController authController;

  const ToggleRoleButton({
    Key? key,
    required this.authController,
  }) : super(key: key);

  @override
  _ToggleRoleButtonState createState() => _ToggleRoleButtonState();
}

class _ToggleRoleButtonState extends State<ToggleRoleButton> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.authController.isDelivery = !widget.authController.isDelivery;
        });
      },
      child: Container(
        width: 44.h,
        height: 44.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: Icon(
            widget.authController.isDelivery
                ? Icons.delivery_dining_outlined
                : Icons.person_outline_rounded,
            size: 24.h,
            color: AppColors.dark,
          ),
        ),
      ),
    );
  }
}
