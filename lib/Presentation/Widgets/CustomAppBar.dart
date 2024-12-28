import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Presentation/Controllers/Dashboard/DashboardController.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? trailingWidget;
  final DashboardController? controller;

  CustomAppBar({
    required this.title,
    this.trailingWidget,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    bool isRTL = Get.locale?.languageCode == 'ar';

    return SafeArea(
      child: Container(
        color: AppColors.background,
        margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
        child: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              if (controller != null) {
                controller!.goToHome();
              } else {
                Get.back();
              }
            },
            child: Container(
              width: 44.h,
              height: 44.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(isRTL ? 3.1416 : 0),
                  child: SvgPicture.asset(
                    'assets/icons/arrow-left.svg',
                    width: 14.h,
                    height: 14.h,
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            title,
            style: AppTextStyles.language.copyWith(
              fontSize: 20.sp,
              color: Color(0xff32324D),
              fontWeight: FontWeight.w400,
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
  Size get preferredSize => Size.fromHeight(100.h);
}
