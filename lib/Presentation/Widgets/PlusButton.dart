import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../App/Color/Color.dart';

class PlusButton extends StatelessWidget {
  VoidCallback onTap;
  PlusButton({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.orangeAccent,
            backgroundColor: Colors.orange.withOpacity(0.19),
            elevation: 0,
          padding: EdgeInsets.zero,
            shape: CircleBorder(),
            ),
        child: Icon(
          Icons.add,
          color: AppColors.primary,
          size: 20.sp,
        ),
      ),
    );
  }
}