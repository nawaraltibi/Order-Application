import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';

class SearchField extends StatelessWidget {
  final Function(String) onSearchChanged;
  final Function(String) onSortSelected;

  SearchField({
    required this.onSearchChanged,
    required this.onSortSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Color(0xFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A434343),
            offset: Offset(0, 10.h),
            blurRadius: 10.h,
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search'.tr,
          hintStyle: AppTextStyles.language.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.fromLTRB(15.w, 15.h,15.w,15.h),
            child: SvgPicture.asset(
              'assets/icons/Search icon filed.svg',
              width: 20.w,
              height: 20.w,
            ),
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.fromLTRB(15.w, 15.h,15.w,15.h),
            child: GestureDetector(
              onTap: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(50.w, 180.h,20.w,0.h),
                  items: const [
                    PopupMenuItem<String>(
                      value: 'date',
                      child: Text('Sort by Date'),
                    ),
                    PopupMenuItem<String>(
                      value: 'patient',
                      child: Text('Sort by Patient'),
                    ),
                  ],
                ).then((value) {
                  if (value != null) {
                    onSortSelected(value);
                  }
                });
              },
              child: SvgPicture.asset(
                'assets/icons/Sort.svg',
                width: 20.w,
                height: 20.w,
              ),
            ),
          ),
          border: InputBorder.none,
        ),
        onChanged: onSearchChanged,
      ),
    );
  }
}
