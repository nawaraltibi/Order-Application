import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? trailingWidget;

  CustomAppBar({
    required this.title,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        child: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 44.h,
              height: 44.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),

              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/arrow-left.svg',
                  width: 14.h,
                  height: 14.h,
                ),
              ),
            ),
          ),
          title: Text(
            title,
            style: AppTextStyles.language.copyWith(
              fontSize: 20.sp,
              color: Color(0xff32324D),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.left,
          ),
          actions: [
            if (trailingWidget != null)
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: trailingWidget!,
              ),
          ],
          centerTitle: false,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
