import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_application/App/Color/Color.dart';

class ToggleRoleButton extends StatefulWidget {
  final Function(bool) onChanged;
  final bool isDelivery;

  const ToggleRoleButton({
    Key? key,
    required this.onChanged,
    this.isDelivery = false,
  }) : super(key: key);

  @override
  _ToggleRoleButtonState createState() => _ToggleRoleButtonState();
}

class _ToggleRoleButtonState extends State<ToggleRoleButton> {
  late bool isDelivery;

  @override
  void initState() {
    super.initState();
    isDelivery = widget.isDelivery;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDelivery = !isDelivery;
        });
        widget.onChanged(isDelivery);
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
            isDelivery
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
